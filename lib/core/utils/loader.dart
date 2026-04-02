import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:unseen/config/colors.dart';

class Loader {
  static void show({String? message}) {
    SVProgressHUD.setBackgroundLayerColor(Colors.black.setOpacity(0.7));
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom);
    SVProgressHUD.setMinimumSize(const Size(80, 80));
    return SVProgressHUD.show(status: message);
  }

  static void dismiss() {
    return SVProgressHUD.dismiss();
  }
}
