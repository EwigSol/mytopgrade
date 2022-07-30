import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mytopgrade/controllers/InProgressController.dart';
import 'package:mytopgrade/controllers/assignment_byID_controller.dart';
import 'package:mytopgrade/controllers/course_byId_controller.dart';
import 'package:mytopgrade/controllers/my_all_courses_controller.dart';
import 'package:mytopgrade/controllers/quiz_byID_controller.dart';
import 'package:mytopgrade/controllers/userController/userController.dart';
import 'package:mytopgrade/controllers/wishlist_controller.dart';
import 'package:mytopgrade/models/pushNotification_Model.dart';
import 'package:mytopgrade/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Bindings/AllBindings.dart';

PushNotification? _notificationInfo;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  //getting token
  FirebaseMessaging.instance.getToken().then((token) {
    print(token);
  });
  //firebase messaging instanse initiated
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.subscribeToTopic('courses');
  //Firebase Meassage Settings
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission: ${settings.authorizationStatus}');
    //if the app is opened.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        showSimpleNotification(
          Text(notification.title!),
          leading: Icon(Icons.notification_add),
          subtitle: Text(
            notification.body!,
          ),
          background: Colors.blue,
          duration: const Duration(seconds: 2),
        );
      }
    });
  } else {
    print('permission denied');
  }

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    PushNotification notification = PushNotification(
      title: message.notification!.title,
      body: message.notification!.body,
      dataTitle: message.data['title'],
      dataBody: message.data['body'],
    );
    // RemoteNotification notification = message.notification!;
    AndroidNotification android = message.notification!.android!;
    if (notification != null && android != null) {
      showSimpleNotification(
        Text(notification.title!),
        leading: Image.asset(
          'assets/images/logo.png',
          height: 50,
        ),
        subtitle: Text(
          notification.body!,
        ),
        background: Colors.blue,
        duration: const Duration(seconds: 2),
      );
    }
  });

  checkForInitialMessahe() async {
    RemoteMessage? message = await messaging.getInitialMessage();
    if (message != null) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
    }
  }

  Get.put(CourseByIDController());
  Get.put(QuizByIDController());
  Get.put(AssignmentByIDController());
  // Get.put(WishlistController());
  // Get.put(InProgressController());
  // Get.put(MyAllCoursesController());
  // Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(
        initialBinding: AllBindings(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
