import 'dart:async';

import 'package:unseen/core/entities/user.entity.dart';
import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/core/types/usecase.dart';
import 'package:unseen/modules/auth/data/models/auth.inputs.dart';
import 'package:unseen/modules/auth/domain/repository/auth_repository.dart';

class RegisterUsecase implements UseCase<User, RegisterInput> {
  final AuthRepository repo;

  RegisterUsecase({required this.repo});

  @override
  FutureOr<RepoResponse<User>> call(RegisterInput params) {
    return repo.register(params);
  }
}
