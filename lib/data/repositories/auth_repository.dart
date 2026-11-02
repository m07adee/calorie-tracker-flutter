import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user.dart';

/// يُرمى عند طلب تسجيل دخول يحتاج Firebase أثناء العمل بوضع التخزين المحلي
class AuthUnavailableException implements Exception {
  const AuthUnavailableException();
}

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;

  /// false في وضع التخزين المحلي حيث يتوفر الدخول كضيف فقط
  bool get supportsAccountSignIn;

  Future<AppUser> signInAnonymously();

  Future<AppUser> signInWithEmail(String email, String password);

  Future<AppUser> registerWithEmail(String email, String password);

  Future<AppUser> signInWithGoogle();

  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? auth, GoogleSignIn? googleSignIn})
      : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  Future<void>? _googleInit;

  @override
  Stream<AppUser?> authStateChanges() => _auth.authStateChanges().map(_toAppUser);

  @override
  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  @override
  bool get supportsAccountSignIn => true;

  @override
  Future<AppUser> signInAnonymously() async {
    final credential = await _auth.signInAnonymously();
    return _toAppUser(credential.user)!;
  }

  @override
  Future<AppUser> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return _toAppUser(credential.user)!;
  }

  // الضيف الذي ينشئ حساباً يُربط حسابه حتى لا يفقد بياناته
  @override
  Future<AppUser> registerWithEmail(String email, String password) async {
    final emailCredential = EmailAuthProvider.credential(email: email, password: password);
    final guest = _auth.currentUser;
    if (guest != null && guest.isAnonymous) {
      final linked = await guest.linkWithCredential(emailCredential);
      return _toAppUser(linked.user)!;
    }
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return _toAppUser(credential.user)!;
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    await (_googleInit ??= _googleSignIn.initialize());
    final account = await _googleSignIn.authenticate();
    final googleCredential = GoogleAuthProvider.credential(idToken: account.authentication.idToken);

    final guest = _auth.currentUser;
    if (guest != null && guest.isAnonymous) {
      try {
        final linked = await guest.linkWithCredential(googleCredential);
        return _toAppUser(linked.user)!;
      } on FirebaseAuthException catch (e) {
        // الحساب موجود مسبقاً: تسجيل دخول عادي إليه
        if (e.code != 'credential-already-in-use') rethrow;
      }
    }
    final credential = await _auth.signInWithCredential(googleCredential);
    return _toAppUser(credential.user)!;
  }

  @override
  Future<void> signOut() async {
    if (_googleInit != null) await _googleSignIn.signOut();
    await _auth.signOut();
  }

  AppUser? _toAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      isAnonymous: user.isAnonymous,
      email: user.email,
      displayName: user.displayName,
    );
  }
}

/// بديل محلي عند غياب Firebase: مستخدم ضيف بمعرّف محفوظ على الجهاز
class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository(this._prefs) {
    final uid = _prefs.getString(_uidKey);
    _current = uid == null ? null : AppUser(uid: uid, isAnonymous: true);
  }

  static const _uidKey = 'local_auth_uid';

  final SharedPreferences _prefs;
  final _changes = StreamController<AppUser?>.broadcast();
  AppUser? _current;

  @override
  Stream<AppUser?> authStateChanges() async* {
    yield _current;
    yield* _changes.stream;
  }

  @override
  AppUser? get currentUser => _current;

  @override
  bool get supportsAccountSignIn => false;

  @override
  Future<AppUser> signInAnonymously() async {
    final uid = 'local-${DateTime.now().microsecondsSinceEpoch}';
    await _prefs.setString(_uidKey, uid);
    final user = AppUser(uid: uid, isAnonymous: true);
    _emit(user);
    return user;
  }

  @override
  Future<AppUser> signInWithEmail(String email, String password) =>
      Future.error(const AuthUnavailableException());

  @override
  Future<AppUser> registerWithEmail(String email, String password) =>
      Future.error(const AuthUnavailableException());

  @override
  Future<AppUser> signInWithGoogle() => Future.error(const AuthUnavailableException());

  @override
  Future<void> signOut() async {
    await _prefs.remove(_uidKey);
    _emit(null);
  }

  void _emit(AppUser? user) {
    _current = user;
    _changes.add(user);
  }
}
