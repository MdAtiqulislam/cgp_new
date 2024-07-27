import 'package:cgp/constraints/app_strings.dart';
import 'package:cgp/services/notification_services.dart';
import 'package:cgp/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get.dart';

import 'app/modules/messaging/controllers/messaging_controller.dart';
import 'app/routes/app_pages.dart';
import 'common_widgets/floating_widget.dart';

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationServices.showNotificationWithoutContext(message);
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = AppStrings.publishableKey;
 // Stripe.publishableKey = "pk_test_51PE2ezGJkp9au0iQVGK9hvtYTmitSBZd8FzSEvWpZvoHkiYUIlblCdkiF5C8CSj5rtfAXYKX04XuEqWh98iEfxEw00wrgKUR21";
  await Stripe.instance.applySettings();
  //Get.put(MessagingController());

  await Firebase.initializeApp(
    //  name: "CGP App",
    // name: "The Mall Bd",
      options:const FirebaseOptions(
        apiKey: 'AIzaSyBbhFT8Iq5hraD98_ZKQrLVO8K3j4s1Zdg',
        appId: '1:1030561817194:android:69faca2339f9fa003fe013',
        messagingSenderId: '1030561817194',
        projectId: "cgp-app-420416",
      )
  );

 // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //systemNavigationBarColor: AppColors.mainColorRed, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark,   // Only honored in Android M and above
      statusBarBrightness: Brightness.dark,
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessagingHandler);

  runApp(
      const MyApp()
  );

 /* runApp(
    ,
  );*/
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseMessaging messaging=FirebaseMessaging.instance;
  NotificationServices notificationServices=NotificationServices();


  @override
  void initState() {
    super.initState();
/*

    NotificationServices().requestNotificationPermission();
    NotificationServices().createNotificationChannel();
    NotificationServices.firebaseInit(context);
    NotificationServices().setupInterruptMessage(context);
    NotificationServices().getDeviceToken().then((value) => print("FCM token: $value"));
*/


    messaging.subscribeToTopic("general_push_notification");
    //messaging.subscribeToTopic("test");
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInterruptMessage(context);
    notificationServices.getDeviceToken().then((value) => print("FCM token: $value"));

  }




  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          locale: const Locale("en","US"),
          fallbackLocale: const Locale("en","US"),
          //translations: Languages(),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: CustomTheme.lightTheme,
          builder: (context,child){

            return Scaffold(
              //appBar: AppBar(), // the common thing.
              body: child,
              bottomNavigationBar:  FloatingWidget(),
            );
          },
        );
      },
    );
  }
}






@pragma('vm:entry-point')
Future<void>_firebaseBackgroundMessagingHandler(RemoteMessage message)async{
/*  await LocalServices.getMyMessages().then((value) async {
    myMessages.value=value;
    myMessages.add(message);
    await LocalServices.storeMyMessages(myMessages);
  });*/
  await Firebase.initializeApp(
    // name: "CGP App",
    // name: "The Mall Bd",
      options:const FirebaseOptions(
        apiKey: 'AIzaSyBbhFT8Iq5hraD98_ZKQrLVO8K3j4s1Zdg',
        appId: '1:1030561817194:android:a7ee0504cc0047543fe013',
        messagingSenderId: '1030561817194',
        projectId: "cgp-app-420416",
      )
  );
  Get.toNamed(Routes.NOTIFICATIONS);
/*  Get.put(NotificationsController());
  Get.find<NotificationsController>().getNotification();*/
}

