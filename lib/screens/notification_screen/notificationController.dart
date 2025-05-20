// ignore_for_file: avoid_print, file_names

import 'package:doc_o_doctor/Model/profileModel.dart';
import 'package:doc_o_doctor/constants/commonwidget.dart';
import 'package:doc_o_doctor/service/rest_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';

class Notificationcontroller extends GetxController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var service = Get.find<RestService>();
  RxString token = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeFCM();
  }

  Future<void> _initializeFCM() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }

    await _initializeLocalNotifications();

    _messaging.getToken().then((fcmToken) async {
      if (fcmToken != null) {
        token.value = fcmToken;
        debugPrint("FCM Token: $fcmToken");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground Notification Received:");
      print("Title: ${message.notification!.title}");
      print("Body: ${message.notification!.body}");
      print("Data: ${message.data}");

      if (message.notification != null) {
        _showLocalNotification(
          message.notification!.title,
          message.notification!.body,
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationInteraction(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        _handleNotificationInteraction(message);
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // print('Background message received: ${message.messageId}');
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  Future<void> _showLocalNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotificationsPlugin.show(
      0,
      title ?? 'Notification',
      body ?? 'No message body',
      notificationDetails,
    );
  }

  // // Wake up the screen to prevent it from turning off
  // Future<void> _wakeUpScreen() async {
  //   print('Miral check wake up screen');
  //   await WakelockPlus.enable(); // Wake up the screen using wakelock_plus
  // }

  // Handle notification interaction
  Future<void> _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    String? payload = notificationResponse.payload;
    // Handle notification tap
    print("Notification tapped with payload: $payload");
    // Navigate to a specific screen if needed
  }

  // Handle interaction when the app is opened from a notification
  void _handleNotificationInteraction(RemoteMessage message) {
    print("Notification opened with data: ${message.data}");
    // Navigate or handle actions based on notification data
  }

  Future<void> sendTokenToServer(
    context, {
    required String deviceId,
    required String deviceType,
    required String fcmToken,
  }) async {
    try {
      var connected = await Commonwidget.checkConnectivity();
      if (!connected) return;
      isLoading.value = true;
      DeviceTokenRequestModel deviceTokenRequestModel =
          DeviceTokenRequestModel();
      deviceTokenRequestModel.token = fcmToken;
      deviceTokenRequestModel.deviceType = deviceType;
      deviceTokenRequestModel.deviceId = deviceId;

      var result = await service.fcmRequest(deviceTokenRequestModel);

      if (result.status ?? false) {
        isLoading.value = false;
      } else {
        isLoading.value = false;
        debugPrint("ERROR :- ${result.message}");
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("ERROR :- ${e.toString()}");
    }
  }

  var isNotificationLoading = false.obs;

  // Future<void> getNotification(context) async {
  //   var connection = await _networkHelper.checkConnectivity(context);
  //   if (!connection) return;
  //   isNotificationLoading.value = true;
  //   try {
  //     var result = await service.getNotification();
  //     if (result.status ?? false) {
  //       isNotificationLoading.value = false;
  //       // spellDetail.value = result.data!;
  //     } else {
  //       isNotificationLoading.value = false;
  //       Commonwidget.showErrorSnackbar(
  //         message: result.message ?? ServiceConfiguration.commonErrorMessage,
  //       );
  //     }
  //   } catch (e) {
  //     isNotificationLoading.value = false;
  //     debugPrint("ERROR :- ${e.toString()}");
  //   }
  // }
}
