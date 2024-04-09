// ignore_for_file: unused_local_variable, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gomechanic/AppConstent/AppConstant.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/SplashScreens/SplashPage.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'utils/indicator.dart';


void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
    print("message title : ${message.notification!.title.toString()}");
    print("message body : ${message.notification!.body.toString()}");
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayOpacity: 0.8,
          overlayColor: Colors.transparent,
          overlayWidget: const CustomCircularProgressIndicator(),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.APP_NAME,
            theme: ThemeData(
              primaryColor: Colors.black,
            ),
             home: GetStorage().read(AppConstant.userName) != null?
             GetStorage().read(AppConstant.userName).toString().isNotEmpty ?
             const DashboardScreen() : const SpalshScreen() : const SpalshScreen(),
          ),
        );
      },
    );
  }
}
