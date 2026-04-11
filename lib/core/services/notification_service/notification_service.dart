import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:unseen/core/utils/error_wrapper.dart';

class NotificationService {
  NotificationService._();

  static const _library = 'NotificationService';
  static final _messaging = FirebaseMessaging.instance;

  /// FCM token for this device. Available after [init] completes.
  /// May remain `null` if the user denied permission or the APNs token
  /// was not yet available (iOS). [UserController] retries automatically.
  static String? fcmToken;

  /// Initialise Firebase Messaging and cache the device FCM token.
  ///
  /// Call once at app startup (before [UserController.getUserDetails]).
  /// Never blocks — a single non-blocking attempt is made to fetch the token.
  /// If the APNs token is not yet ready (iOS simulator / cold start), [fcmToken]
  /// stays null and [UserController] will retry via [fetchToken].
  static Future<void> init() async {
    await ErrorWrapper.async<void>(
      () async {
        // Request permission (iOS + Android 13+). On older Android this is a no-op.
        final settings = await _messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        log(
          'Notification permission: ${settings.authorizationStatus}',
          name: _library,
        );

        if (settings.authorizationStatus == AuthorizationStatus.denied) {
          log(
            'Notification permission denied — skipping token fetch',
            name: _library,
          );
          return;
        }

        if (GetPlatform.isIOS) await _messaging.getAPNSToken();

        // Single non-blocking attempt. On iOS the APNs token may not be ready
        // yet (especially on simulators); the exception is caught by
        // ErrorWrapper and fcmToken stays null — UserController retries.
        fcmToken = await _messaging.getToken();

        log(
          fcmToken != null ? 'FCM token obtained' : 'FCM token unavailable',
          name: _library,
        );

        // Refresh listener — keep the cached token current whenever it rotates.
        _messaging.onTokenRefresh.listen((newToken) {
          fcmToken = newToken;
          log('FCM token refreshed', name: _library);
        });
      },
      library: _library,
      description: 'while initialising notification service',
    );
  }

  // ── Public helpers ────────────────────────────────────────────────────────

  /// Re-attempts fetching the FCM token from Firebase without re-requesting
  /// permission. Called by [UserController]'s retry timer when [fcmToken] is
  /// still null after [init].
  ///
  /// Single non-blocking attempt — no internal polling. If the APNs token is
  /// still not ready the exception is swallowed and `null` is returned;
  /// the timer will call this again on its next tick.
  static Future<String?> fetchToken() async {
    await ErrorWrapper.async<void>(
      () async {
        if (fcmToken != null) return;
        if (GetPlatform.isIOS) await _messaging.getAPNSToken();
        fcmToken = await _messaging.getToken();
        log(
          fcmToken != null
              ? 'FCM token obtained on retry'
              : 'FCM token still unavailable',
          name: _library,
        );
      },
      library: _library,
      description: 'while retrying FCM token fetch',
    );
    return fcmToken;
  }
}
