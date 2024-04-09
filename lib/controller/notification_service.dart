// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
// import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/notification_widget.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/helper/custom_dialog.dart';
import 'package:gomechanic/utils/all_image.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

import '../Widget/service_type_details.dart';

class NotificationServices {
  DetailsController detailsController = Get.put(DetailsController());
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // void requestNotificationPermission() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: true,
  //     badge: true,
  //     carPlay: true,
  //     criticalAlert: true,
  //     provisional: true,
  //     sound: true,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     if (kDebugMode) {
  //       print('user granted permission');
  //     }
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     if (kDebugMode) {
  //       print('user granted provisional permission');
  //     }
  //   } else {
  //     //app setting.AppSettings.openNotificationSettings();
  //     if (kDebugMode) {
  //       AppSettings.openAppSettings();
  //       print('user denied permission');
  //     }
  //   }
  // }

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveBackgroundNotificationResponse: (payload) async{
      return handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification!.android ;
      if (kDebugMode) {
        print("object117");
        print(
            "notifications title ====>>>>> ${notification!.title.toString()}");
        print("notifications body ====>>>>> ${notification.body.toString()}");
      }
      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
        forgroundMessage();
      }
    });
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        // 'Go mechanic',
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        showBadge: true,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('user'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          // 'Go mechanic',
      channel.id.toString(),
      channel.name.toString(),
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      sound: const RawResourceAndroidNotificationSound('user'),
    );

    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  // get token key
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }
   FcmToken() async {
   final token = await FirebaseMessaging.instance.getToken();
  }
  // token refresh show
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onBackgroundMessage((message) async {});

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Get.to(() => const AllNotifications());
      handleMessage(context, event);
    });
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  var dataList = [];
  void handleMessage(BuildContext context, RemoteMessage message) async {
    print("notification screen");
    print("booking noti type ${message.data['noti_type'].toString()}");
    print("booking details5 ${message.data['id']}");
    if (message.data['noti_type'] == "1") {
      bool status = await detailsController
          .getBookingDetailsNetworkApi(message.data['id']);
      if (status == true) {
        bool status = await detailsController
            .getBookingDetailsNetworkApi(message.data['id']);
        if (status == true) {
          Get.to(() => const ServiceTypeDetails());
        }
      }
    } else if (message.data['noti_type'].toString() == "accept_service") {
      Get.offAll(() => const DashboardScreen());
      bool status = await detailsController
          .getBookingDetailsNetworkApi(message.data['id']);
      if (status == true) {
        showAnimation(context, message.data['id']);
      }
    } else {
      Get.offAll(() => const AllNotifications());
    }
  }

  void showAnimation(BuildContext context, bookingId) {
    LoginController controller = Get.put(LoginController());
    return showAnimatedDialog(
        Get.context!,
        Center(
          child: Container(
            width: 300.w,
            height: 300.h,
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
            decoration: BoxDecoration(
                color: Theme.of(Get.context!).cardColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              GetBuilder<DetailsController>(builder: (controller) {
                var data = controller.getBookingDetails.value.data;
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data.userProfile.toString().isNotEmpty?
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 0.5.r, color: TColor.grey),
                            image: DecorationImage(image: NetworkImage(AppConstants.BASE_URL+data.userProfile.toString()),fit: BoxFit.cover)
                        ),
                      )
                      : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 0.5.r, color: TColor.grey),
                          image: DecorationImage(image: AssetImage(Images.defaultProfile.toString()),fit: BoxFit.cover)
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Row(
                        children: [
                          Text(
                            "Order No        : ",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault2,
                                color: TColor.Text,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(width: 8.0.w),
                          Text(
                            data.bookingNo ?? 'N/A',
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: TColor.black.withAlpha(150),
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0.h),
                      Row(
                        children: [
                          Text(
                            "Owner             :",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault2,
                                color: TColor.Text,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(width: 8.0.w),
                          Text(
                            data.ownerName.toString(),
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault2,
                                color: TColor.black.withAlpha(150),
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0.h),
                      Row(
                        children: [
                          Text(
                            "Service Type  :",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault2,
                                color: TColor.Text,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(width: 8.0.w),
                          Text(
                            data.serviceType.toString(),
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault2,
                                color: TColor.black.withAlpha(150)
                                ,decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0.h),
                      Row(
                        children: [
                          Text(
                            "Mobile No.     :",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault2,
                                color: TColor.Text,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(width: 8.0.w),
                          Text(
                            data.mobileNo.toString(),
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault2,
                                color: TColor.black.withAlpha(150),decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 30.0.h,
                    width: 90.0.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, elevation: 0.0),
                      onPressed: (){
                              detailsController.BookingAcceptNetworkApi(bookingId);
                              Get.back(result: {
                                controller.getVendorItemDataCountNetworkApi(),
                                controller.getVendorItemDataCountNetworkApi(),
                                controller.getBannerNetworkApi(),
                                controller.getAddressFromLatLong(),
                                controller.getShopDetailsNetworkApi(),
                              });
                      },
                      child: Text('Accept'.tr,
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: TColor.white,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                  Container(
                    height: 30.0.h,
                    width: 90.0.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(result: {
                          controller.getVendorItemDataCountNetworkApi(),
                          controller.getVendorItemDataCountNetworkApi(),
                          controller.getBannerNetworkApi(),
                          controller.getAddressFromLatLong(),
                          controller.getShopDetailsNetworkApi(),
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                      ),
                      child: Text('Reject'.tr,
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: TColor.white,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
        dismissible: false);
  }
}
