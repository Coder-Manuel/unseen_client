import 'package:get/get.dart';
import 'package:unseen/core/routes/app_route.dart';
import 'package:unseen/modules/auth/presentation/pages/login_page.dart';
import 'package:unseen/modules/auth/presentation/pages/register_garage_page.dart';

class AuthRoutes implements AppRoute {
  @override
  List<GetPage> pages = [
    GetPage(name: LoginPage.route, page: () => LoginPage()),
    GetPage(name: RegisterPage.route, page: () => RegisterPage()),
  ];
}
