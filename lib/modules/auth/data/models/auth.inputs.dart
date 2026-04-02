class RegisterInput {
  final String name;
  final String location;
  final ({String name, String email, String phone, String password}) owner;

  RegisterInput({
    required this.name,
    required this.location,
    required this.owner,
  });

  Map<String, dynamic> toMap() => {
    'input': {
      'email': owner.email,
      'name': owner.name,
      'phone': owner.phone,
      'password': owner.password,
      'garage': {'name': name, 'location': location},
    },
  };
}

class LoginInput {
  final String email;
  final String password;

  LoginInput({required this.email, required this.password});

  Map<String, dynamic> toMap() => {
    'input': {'email': email, 'password': password},
  };
}
