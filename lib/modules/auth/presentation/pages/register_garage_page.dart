import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unseen/config/colors.dart';
import 'package:unseen/core/utils/size.util.dart';
import 'package:unseen/modules/auth/presentation/controllers/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  static const String route = '/register_page';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 20),
                1.horizontalSpace,
                Text('Back'),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Text(
                  'Register Your Garage',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                25.verticalSpace,
                Text(
                  'Garage Name',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                6.verticalSpace,
                // AppFormField(
                //   hint: 'Premium Auto Spare',
                //   controller: controller.garageNameCTRL,
                //   validator: (v) {
                //     if (v?.isNotEmpty == true) return null;
                //     return 'Garage name is required';
                //   },
                // ),
                15.verticalSpace,
                Text(
                  'Owner Name',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                6.verticalSpace,
                // AppFormField(
                //   hint: 'John Doe',
                //   controller: controller.ownerNameCTRL,
                //   validator: (v) {
                //     if (v?.isNotEmpty == true) return null;
                //     return 'Owner name is required';
                //   },
                // ),
                15.verticalSpace,
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                6.verticalSpace,
                // AppFormField(
                //   hint: 'john@example.com',
                //   controller: controller.ownerEmailCTRL,
                //   validator: (v) {
                //     if (v?.isValidEmail == true) return null;
                //     return 'Email is invalid';
                //   },
                // ),
                15.verticalSpace,
                Text(
                  'Phone Number',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                6.verticalSpace,
                // AppFormField(
                //   isPhone: true,
                //   hint: '0712 or 0123',
                //   onPhoneSaved: (v) => controller.phoneNumber.value = v,
                // ),
                15.verticalSpace,
                Text(
                  'Location',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                6.verticalSpace,
                // AppFormField(
                //   hint: 'City, State',
                //   controller: controller.garageLocationCTRL,
                //   validator: (v) {
                //     if (v?.isNotEmpty == true) return null;
                //     return 'Location is required';
                //   },
                // ),
                15.verticalSpace,
                Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                //     validator: (v) {
                //       if (v?.isStrongPassword == true) return null;
                //       return 'Atleast (Uppercase, lowercase, number & special char)';
                //     },
                //   );
                // }),
                15.verticalSpace,
                Text(
                  'Confirm Password',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                6.verticalSpace,
                // Obx(() {
                //   return AppFormField(
                //     hint: 'Min 8 Characters',
                //     controller: controller.confirmPasswordCTRL,
                //     obscureText: controller.obscurePass.value,
                //     suffix: GestureDetector(
                //       onTap: () => controller.toggleObscurePass(),
                //       child: Icon(
                //         controller.obscurePass.value
                //             ? Icons.visibility_off
                //             : Icons.visibility,
                //       ),
                //     ),
                //     validator: (v) {
                //       if (v == controller.passwordCTRL.text) return null;
                //       return 'Passwords dont match';
                //     },
                //   );
                // }),
                40.verticalSpace,
                TextButton(
                  onPressed: () async => await controller.addGarage(formKey),
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(Size(Get.width, 50)),
                    backgroundColor: WidgetStateProperty.all(
                      ColorPallete.primaryColor,
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  child: Text('Create Garage', style: TextStyle(fontSize: 18)),
                ),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
