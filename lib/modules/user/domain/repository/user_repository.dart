import 'package:unseen/core/entities/user.entity.dart';
import 'package:unseen/core/types/repo_reponse.type.dart';

abstract class UserRepository {
  Future<RepoResponse<User>> getUserInfo();
  Future<RepoResponse<void>> updateFcmToken(String token);
}
