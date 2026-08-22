class AuthRequest {
  final String? fName;
  final String? lName;
  final String email;
  final String password;
  AuthRequest({
    this.fName,
    this.lName,
    required this.email,
    required this.password,
  });
}
