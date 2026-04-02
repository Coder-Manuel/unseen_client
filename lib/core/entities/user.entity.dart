import 'package:unseen/core/entities/base.entity.dart';

abstract class User extends BaseEntity {
  final String? name;
  final String? email;
  final String? phone;
  final String? status;

  User({
    super.id,
    this.name,
    this.email,
    this.phone,
    this.status,
    super.createdAt,
  });
}
