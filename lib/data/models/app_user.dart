class AppUser {
  const AppUser({
    required this.uid,
    required this.isAnonymous,
    this.email,
    this.displayName,
  });

  final String uid;
  final bool isAnonymous;
  final String? email;
  final String? displayName;
}
