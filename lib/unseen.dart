import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unseen/config/colors.dart';
import 'package:unseen/core/routes/app_pages.dart';

class UnSeen extends StatelessWidget {
  const UnSeen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UnSeen',
      showPerformanceOverlay: kProfileMode,
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPallete.primaryColor),
      ),
    );
  }
}
