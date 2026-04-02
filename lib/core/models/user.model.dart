import 'package:unseen/core/entities/user.entity.dart';

class UserModel extends User {
  UserModel({super.id, super.email, super.name, super.phone, super.createdAt});

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
    id: data['id'],
    email: data['email'],
    name: data['name'],
    phone: data['phone'],
    createdAt: data['createdAt'],
  );
}
