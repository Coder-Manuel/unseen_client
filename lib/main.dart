import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unseen/core/initializer.dart';
import 'package:unseen/core/services/monitor_service/monitor.service.dart';
import 'package:unseen/unseen_client.dart';

void main() {
  runZonedGuarded(
    () async {
      // * Init core services/utils
      await Initializer.init();

      runApp(const UnSeenClient());
    },
    (Object ex, StackTrace stack) {
      MonitorService.report(ex: ex, stack: stack, library: 'Main ZoneGuard');
    },
  );
}
