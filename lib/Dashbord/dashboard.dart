// ignore_for_file: deprecated_member_use, file_names, avoid_print

import 'package:animated_switch/animated_switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gomechanic/AppConstent/AppConstant.dart';
import 'package:gomechanic/UtilMethode/utilmethode.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/banner_screen.dart';
import 'package:gomechanic/Widget/drawer_home.dart';
import 'package:gomechanic/Widget/item_data.dart';
import 'package:gomechanic/Widget/notification_widget.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/controller/notification_service.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  NotificationServices notificationServices = NotificationServices();
  final RxBool isLightTheme = false.obs;
  final LoginController controller = Get.put(LoginController());
  final DetailsController detailsController = Get.put(DetailsController());
  RxInt activeStep = 0.obs;

  @override
  void initState() {
    controller.getAddressFromLatLong();
    controller.getBannerNetworkApi();
    detailsController.UpdateAddressNetWorkApi();
    controller.getShopDetailsNetworkApi();
    // notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        controller.FCM_TOKEN.value = value;
        // print('device token key ======>>>>>>>>>  ${controller.FCM_TOKEN.value}');
      }
    });
    // controller.currentAddressNetworkApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    detailsController.saveDataRegistration();
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(

        appBar: AppBar(
          iconTheme:  IconThemeData(
            size: 25.r,
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: TColor.themecolor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                GetStorage().read(AppConstant.shopName)??"No Shop Added",
                style: robotoMedium.copyWith(
                 fontSize: Dimensions.fontSizeDefault2, color: Colors.white),
              ),
              Obx(() => Text(
                controller.current_address.value.toString().isNotEmpty?controller.current_address.value.toString():"Wait loading...",
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeExtraSmall, color: Colors.white),
              )
              )
            ],
          ),
          leadingWidth: 30.w,
          actions: [
            // GestureDetector(
            //   onTap: () => Get.to(()=> const AllNotifications()),
            //   child: Icon(Icons.notifications_on,size: 20.sp,color: TColor.white,),
            // ),
            SizedBox(width: 10.0.w),
            // AnimatedSwitch(
            //   textOff: "Off",
            //   textOn: "On",
            //   value: GetStorage().read(AppConstant.shop_open).toString() == "2" ? false : true,
            //   iconOff: Icons.mood,
            //   iconOn: Icons.mood_bad_rounded,
            //   onTap: () async{
            //     bool status = await controller.shopOpenCloseNetworkApi();
            //     if(status == true){
            //       BaseController().successSnack(controller.shopOpenClose.value.message.toString());
            //     }
            //   },
            //   textStyle: smallTextStyle.copyWith(
            //       fontWeight: FontWeight.bold, color: Colors.white),
            // ),
            SizedBox(
              width: 5.w,
            )
          ],
          bottom: PreferredSize(
            preferredSize:  Size.fromHeight(35.w),
            child: Container(
              width: Get.width,
              height: 30.0.h,
              alignment: Alignment.center,
              color: TColor.Theme_Color,
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                        size: 22.sp,
                      )),
                  SizedBox(width: 5.0.w),
                  Text(
                    "${controller.storage.read(AppConstant.phone)}",
                    style: bodyText1Style.copyWith(
                        color: Colors.white, fontSize: 18.sp),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.house_outlined,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5.0.w),
                  Text(
                    "9696",
                    style: bodyText1Style.copyWith(
                        color: Colors.white, fontSize: 18.sp),
                  )
                ],
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          color: TColor.themecolor,
          onRefresh: () {
            return Future.delayed(Duration.zero, () {
              controller.getVendorItemDataCountNetworkApi();
              // controller.currentAddressNetworkApi();
              controller.getBannerNetworkApi();
              controller.getAddressFromLatLong();
              controller.getShopDetailsNetworkApi();
            });
          },
          child: GetBuilder<LoginController>(
              builder: (controller){
                return ListView(
                  children: [
                    const BannerView(),
                    SizedBox(height: 10.0.h),
                    const ItemData(),
                  ],
                );
              }
          ),
        ),
        drawer: const DrawerScreen(),
        // bottomSheet: Container(
        //   height: 80.h,
        //   color: Colors.blue.shade300,
        //   width: Get.width,
        //   margin: const EdgeInsets.all(10.0),
        //   child: Text(controller.FCM_TOKEN.value.toString(),style: robotoText.copyWith(color: Colors.black),),
        // ),
      ),
    );
  }
}
