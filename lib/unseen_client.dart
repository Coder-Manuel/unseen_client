import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unseen/config/theme.dart';
import 'package:unseen/core/routes/app_pages.dart';
import 'package:unseen/modules/home/presentation/pages/splash_page.dart';

class UnSeenClient extends StatelessWidget {
  const UnSeenClient({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UnSeen Client',
      showPerformanceOverlay: kProfileMode,
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: SplashPage.route,
      theme: AppTheme.dark,
    );
  }
}
