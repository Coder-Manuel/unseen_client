import 'dart:async';

import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/core/types/usecase.dart';
import 'package:unseen/modules/user/domain/repository/user_repository.dart';

class UpdateFcmTokenUseCase implements UseCase<void, String> {
  final UserRepository repo;
  UpdateFcmTokenUseCase({required this.repo});

  @override
  FutureOr<RepoResponse<void>> call(String token) {
    return repo.updateFcmToken(token);
  }
}
