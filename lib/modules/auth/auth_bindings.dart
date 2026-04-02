import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unseen/modules/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:unseen/modules/auth/data/sources/remote_auth_datasource.dart';
import 'package:unseen/modules/auth/domain/repository/auth_repository.dart';
import 'package:unseen/modules/auth/domain/usecases/login.usecase.dart';
import 'package:unseen/modules/auth/domain/usecases/logout.usecase.dart';
import 'package:unseen/modules/auth/domain/usecases/register.usecase.dart';
import 'package:unseen/modules/auth/presentation/controllers/login_controller.dart';
import 'package:unseen/modules/auth/presentation/controllers/register_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteAuthDatasource>(
      () => RemoteAuthDatasourceImpl(client: Get.find<SupabaseClient>()),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDatasource: Get.find<RemoteAuthDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(repo: Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<RegisterUsecase>(
      () => RegisterUsecase(repo: Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<LogoutUseCase>(
      () => LogoutUseCase(repo: Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<RegisterController>(() => RegisterController(), fenix: true);
  }
}
