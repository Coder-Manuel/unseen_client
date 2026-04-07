import 'package:unseen/core/entities/user.entity.dart';
import 'package:unseen/core/models/user.model.dart';
import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/core/utils/error_wrapper.dart';
import 'package:unseen/modules/user/data/sources/remote_user_datasource.dart';
import 'package:unseen/modules/user/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final _library = 'User Repository';
  final RemoteUserDatasource remoteDatasource;

  UserRepositoryImpl({required this.remoteDatasource});

  @override
  Future<RepoResponse<User>> getUserInfo() async {
    final response = await ErrorWrapper.async<RepoResponse<User>>(
      () async {
        final data = await remoteDatasource.getUseInfo();

        if (data == null || data.isEmpty) {
          return FailureResponse('No User Data');
        }

        final user = UserModel.fromMap(data);

        return SuccessResponse(user);
      },
      onError: (error) {
        return FailureResponse('An error occurred, Kindly Retry');
      },
      library: _library,
      description: 'while fetching user data',
    );

    return response!;
  }
}
