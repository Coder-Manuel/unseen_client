import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:unseen/core/utils/loader.dart';
import 'package:unseen/core/utils/toast.dart';
import 'package:unseen/modules/auth/data/models/auth.inputs.dart';
import 'package:unseen/modules/auth/domain/usecases/register.usecase.dart';

class RegisterController extends GetxController {
  final registerUsecase = Get.find<RegisterUsecase>();

  final garageNameCTRL = TextEditingController();
  final garageLocationCTRL = TextEditingController();
  final ownerNameCTRL = TextEditingController();
  final ownerEmailCTRL = TextEditingController();
  final passwordCTRL = TextEditingController();
  final confirmPasswordCTRL = TextEditingController();

  Rx<String?> phoneNumber = Rx<String?>(null);

  Rx<bool> obscurePass = true.obs;

  void toggleObscurePass() => obscurePass.value = !obscurePass.value;

  Future<void> addGarage(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() != true) return;
    formKey.currentState?.save();

    Loader.show(message: 'Registering...');
    final response = await registerUsecase(
      RegisterInput(
        name: garageNameCTRL.text.trim(),
        location: garageLocationCTRL.text.trim(),
        owner: (
          name: ownerNameCTRL.text.trim(),
          email: ownerEmailCTRL.text.trim(),
          phone: phoneNumber.value ?? '',
          password: passwordCTRL.text.trim(),
        ),
      ),
    );
    Loader.dismiss();

    response.fold(
      (ex) {
        Toast.error(ex.message);
      },
      (data) {
        Toast.success('Welcome ${ownerNameCTRL.text} to ${data.name}');
        // Get.offAllNamed(HomePage.route);
      },
    );
  }
}
