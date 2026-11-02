import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/app_user.dart';
import '../data/repositories/auth_repository.dart';
import 'core_providers.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (ref.watch(firebaseEnabledProvider)) return FirebaseAuthRepository();
  return LocalAuthRepository(ref.watch(sharedPreferencesProvider));
});

final authStateProvider = StreamProvider<AppUser?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges(),
);
