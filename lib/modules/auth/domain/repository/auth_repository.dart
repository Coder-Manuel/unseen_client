import 'package:unseen/core/entities/user.entity.dart';
import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/modules/auth/data/models/auth.inputs.dart';

abstract class AuthRepository {
  Future<RepoResponse<User>> login(LoginInput input);
  Future<RepoResponse<User>> register(RegisterInput input);
  Future<RepoResponse<bool>> logout();
}
