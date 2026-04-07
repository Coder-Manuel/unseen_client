class RegisterInput {
  RegisterInput();

  Map<String, dynamic> toMap() => {};
}

class LoginInput {
  final String? email;
  final String? phone;
  final String? password;
  final String? idToken;
  final String? accessToken;

  LoginInput({
    this.email,
    this.phone,
    this.password,
    this.idToken,
    this.accessToken,
  });

  Map<String, dynamic> toMap() => {
    'email': email,
    'phone': phone,
    'password': password,
    'idToken': idToken,
    'accessToken': accessToken,
  };
}
