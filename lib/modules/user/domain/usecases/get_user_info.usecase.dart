import 'dart:async';

import 'package:unseen/core/entities/user.entity.dart';
import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/core/types/usecase.dart';
import 'package:unseen/modules/user/domain/repository/user_repository.dart';

class GetUserInfoUseCase implements UseCase<User, dynamic> {
  final UserRepository repo;
  GetUserInfoUseCase({required this.repo});

  @override
  FutureOr<RepoResponse<User>> call([params]) {
    return repo.getUserInfo();
  }
}
