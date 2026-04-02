import 'package:unseen/core/entities/user.entity.dart';
import 'package:unseen/core/models/user.model.dart';
import 'package:unseen/core/types/repo_reponse.type.dart';
import 'package:unseen/core/utils/error_wrapper.dart';
import 'package:unseen/modules/auth/data/models/auth.inputs.dart';
import 'package:unseen/modules/auth/data/sources/remote_auth_datasource.dart';
import 'package:unseen/modules/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _library = 'Auth Repository';
  final RemoteAuthDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<RepoResponse<User>> login(LoginInput input) async {
    final response = await ErrorWrapper.async<RepoResponse<User>>(
      () async {
        final res = await remoteDatasource.loginWithPassword(
          data: input.toMap(),
        );

        if (res.session == null) {
          return FailureResponse('Invalid credentials, Kindly Retry');
        }

        final user = UserModel.fromMap(res.user?.toJson() ?? {});

        return SuccessResponse(user);
      },
      onError: (error) {
        return FailureResponse('An error occurred, Kindly Retry');
      },
      library: _library,
      description: 'while user login',
    );

    return response!;
  }

  @override
  Future<RepoResponse<User>> register(RegisterInput input) async {
    final response = await ErrorWrapper.async<RepoResponse<User>>(
      () async {
        final res = await remoteDatasource.signUp(
          data: input.toMap(),
          password: input.owner.password,
        );
        if (res.session == null) {
          return FailureResponse('Unable to register, Kindly Retry');
        }

        final user = UserModel.fromMap(res.user?.toJson() ?? {});

        return SuccessResponse(user);
      },
      onError: (error) {
        return FailureResponse('An error occurred, Kindly Retry');
      },
      library: _library,
      description: 'while registering',
    );

    return response!;
  }

  @override
  Future<RepoResponse<bool>> logout() async {
    final response = await ErrorWrapper.async<RepoResponse<bool>>(
      () async {
        return SuccessResponse(true);
      },
      onError: (error) {
        return FailureResponse('An error occurred, Kindly Retry');
      },
      library: _library,
      description: 'while user logout',
    );

    return response!;
  }
}
