import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unseen/config/colors.dart';
import 'package:unseen/core/utils/size.util.dart';
import 'package:unseen/modules/auth/presentation/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  static const String route = '/login_page';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Image.asset('assets/images/logo_type.png', height: 50),
              ),
              15.verticalSpace,
              Text(
                'Let’s get you started',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              40.verticalSpace,
              Row(
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              6.verticalSpace,
              // AppFormField(
              //   hint: 'john@example.com',
              //   controller: controller.emailCTRL,
              //   validator: (v) {
              //     if (v?.isValidEmail == true) return null;
              //     return 'Email is invalid';
              //   },
              // ),
              20.verticalSpace,
              Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              6.verticalSpace,
              // Obx(() {
              //   return AppFormField(
              //     hint: 'Min 8 Characters',
              //     controller: controller.passwordCTRL,
              //     obscureText: controller.obscurePass.value,
              //     suffix: GestureDetector(
              //       onTap: () => controller.toggleObscurePass(),
              //       child: Icon(
              //         controller.obscurePass.value
              //             ? Icons.visibility_off
              //             : Icons.visibility,
              //       ),
              //     ),
              //   );
              // }),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: ColorPallete.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              40.verticalSpace,
              TextButton(
                onPressed: () async => await controller.login(formKey),
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(Size(Get.width, 50)),
                  backgroundColor: WidgetStateProperty.all(
                    ColorPallete.primaryColor,
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                child: Text('Login', style: TextStyle(fontSize: 18)),
              ),
              const Spacer(),
              GestureDetector(
                // onTap: () => Get.toNamed(OnboardingPage.route),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?  ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: ColorPallete.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              70.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
