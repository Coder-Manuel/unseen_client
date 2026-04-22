import 'dart:async';

import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/core/types/usecase.dart';
import 'package:unseen/modules/auth/data/models/auth.inputs.dart';
import 'package:unseen/modules/auth/domain/repository/auth_repository.dart';

class VerifyResetOtpUseCase implements UseCase<bool, VerifyOtpInput> {
  final AuthRepository repo;
  VerifyResetOtpUseCase({required this.repo});

  @override
  FutureOr<RepoResponse<bool>> call(VerifyOtpInput params) =>
      repo.verifyPasswordResetOtp(params);
}
