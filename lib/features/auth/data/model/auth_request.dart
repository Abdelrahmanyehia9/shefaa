class AuthRequest {
  final String? username;
  final String email;
  final String password;
  AuthRequest({
     this.username,
     required this.email,
     required this.password,
  });
}
