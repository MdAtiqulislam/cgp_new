
/*
import 'dart:io';

import 'package:cgp/app/routes/app_pages.dart';
import 'package:cgp/other_controllers/appbar_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


class NotificationServices {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static var myMessages=<RemoteMessage>[].obs;


  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("User granted permission");
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("User granted provisional permission");
      }
    } else {
      if (kDebugMode) {
        print("User denied permission");
      }
    }
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handelMessageClick(context,message);
        });
  }


  Future<void> firebaseInit(BuildContext context) async {
    //messaging.subscribeToTopic("general_push_notification");
    FirebaseMessaging.onMessage.listen((message)  {

      if(Platform.isIOS){
        foregroundMessage();
      }

      if(Platform.isAndroid){
        initLocalNotification(context, message);
        showNotification(message);
      }else{
        showNotification(message);
      }
    //  addNotificationToLocalStorage(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel =  const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      showBadge: true,
       importance: Importance.high,
      description: 'This channel is used for important notifications.', // description
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "channel description",
      importance: Importance.high,
      priority: Priority.high,
      channelShowBadge: true,
      ticker: "ticker",
          fullScreenIntent: true,
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      print("Notification received");
       _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }


 static Future<void> handelMessageClick(BuildContext context,RemoteMessage message) async {
 print("Message Data: ${message.data}");
 Get.toNamed(Routes.NOTIFICATIONS);
  }


  Future <void> setupInterruptMessage(BuildContext context)async {
    RemoteMessage? initialMessage=await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage!=null){
      handelMessageClick(context, initialMessage);
    //  addNotificationToLocalStorage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      handelMessageClick(context,event);
    });
  }

  Future foregroundMessage()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}*/






import 'dart:io';
import 'package:cgp/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../app/routes/app_pages.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static var myMessages = <RemoteMessage>[].obs;
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("User granted permission");
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("User granted provisional permission");
      }
    } else {
      if (kDebugMode) {
        print("User denied permission");
      }
    }
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handelMessageClick(context, message);
      },
    );
  }

  Future<void> firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isIOS) {
        foregroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel_tradebar_customer', // id
      'High Importance Notifications', // title
      showBadge: true,
      importance: Importance.high,
      description: 'This channel is used for important notifications.', // description
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.high,
      priority: Priority.high,
      channelShowBadge: true,
      ticker: "ticker",
      fullScreenIntent: true,
      sound: const RawResourceAndroidNotificationSound('sound'),
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'sound.aiff',
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        notificationDetails,
      );
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  static Future<void> handelMessageClick(BuildContext context, RemoteMessage message) async {
    Get.put(NotificationsController());
    Get.find<NotificationsController>().getNotification();
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  Future<void> setupInterruptMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handelMessageClick(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      handelMessageClick(context, event);
    });
  }

  Future<void> foregroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}


