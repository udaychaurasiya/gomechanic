import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gomechanic/AppConstent/AppConstant.dart';
import 'package:gomechanic/Dashbord/Profile.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/SplashScreens/SplashPage.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/ContactUs.dart';
import 'package:gomechanic/Widget/Help.dart';
import 'package:gomechanic/Widget/notification_widget.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/helper/custom_list_tile.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/indicator.dart';
import 'package:gomechanic/utils/style.dart';
import 'shop_details_update.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}
  final LoginController controller = Get.find();

class _DrawerScreenState extends State<DrawerScreen> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width / 1.3,
      height: height,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              // height: 160.r,
              alignment: Alignment.centerLeft,
              child: DrawerHeader(
                decoration: BoxDecoration(color: TColor.themecolor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: ()async{
                        Navigator.pop(context);
                        bool status = await controller.shopOpenCloseNetworkApi();
                        if(status==true){
                          Get.to(()=>const ProfileScreen());
                        }
                      },
                      child: Row(
                        children: [
                          Obx(
                            () => controller.rxPath.isEmpty
                                ? Container(
                                    height:65.r,
                                    width: 65.r,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0.w,
                                            color: TColor.lightGrey),
                                        borderRadius:
                                            BorderRadius.circular(50.0.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: TColor.white,
                                          ),
                                          BoxShadow(
                                            color: TColor.lightGrey,
                                            spreadRadius: -12.0,
                                            blurRadius: 12.0,
                                          ),
                                        ],
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                AppConstants.BASE_URL+GetStorage().read(AppConstant.profile).toString()),
                                            fit: BoxFit.cover)),
                                    child: Obx(
                                          () => controller.isLoading.value
                                          ? const CustomCircularProgressIndicator()
                                          : const SizedBox(),
                                    ))
                                : Container(
                                    height: Get.height * 0.4/3.5,
                                    width: Get.height * 0.4/3.5,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0.w,
                                            color: TColor.lightGrey),
                                        borderRadius:
                                            BorderRadius.circular(50.0.r),
                                        image: DecorationImage(
                                            image: FileImage(
                                                File(controller.rxPath.value)),
                                            fit: BoxFit.cover)),
                                    child: Obx(
                                          () => controller.isLoading.value
                                          ? const CustomCircularProgressIndicator()
                                          : const SizedBox(),
                                    )
                                  ),
                          ),
                          Container(
                            padding:  EdgeInsets.only(left: 5.w),
                            width: width * 0.44,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  GetStorage().read(AppConstant.name)??"NA",
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: TColor.white.withOpacity(0.9)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 3.0.h,
                                ),
                                Text(GetStorage().read(AppConstant.email)??"NA",
                                  style: robotoRegular.copyWith(color: TColor.white.withOpacity(0.9)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomListTile(
                      onTap: () async{
                          controller.getVendorItemDataCountNetworkApi();
                          // controller.currentAddressNetworkApi();
                          controller.getBannerNetworkApi();
                          controller.getAddressFromLatLong();
                          controller.getShopDetailsNetworkApi();
                          Get.offAll(()=>DashboardScreen());
                      },
                      text: 'Dashboard',
                      icon: Icons.dashboard_outlined),
                  const Divider(),
                  CustomListTile(
                      onTap: ()async{
                        Navigator.pop(context);
                        bool status = await controller.shopOpenCloseNetworkApi();
                        if(status==true){
                          Get.to(()=>const ProfileScreen());
                        }
                      },
                      text: 'Profile',
                      icon: Icons.person),
                  const Divider(),
                  CustomListTile(
                      onTap: (){
                        Navigator.pop(context);
                        Get.to(()=>const ShopDetailsUpdate());
                      },
                      text: 'Shop Details',
                      icon: Icons.details_outlined),
                  // const Divider(),
                  // CustomListTile(
                  //     onTap: (){
                  //       Navigator.pop(context);
                  //       Get.to(()=>const AllNotifications());
                  //     },
                  //     text: 'Notifications',
                  //     icon: Icons.notifications_on),
                 /* const Divider(),
                  const CustomListTile(
                      text: 'Sale',
                      icon: Icons.sell_outlined),
                  const Divider(),
                  CustomListTile(
                      onTap: (){
                        Get.to(()=>const ServiceTypeDetails());
                      },
                      text: 'Service Type',
                      icon: Icons.miscellaneous_services),
                  const Divider(),
                  const CustomListTile(
                      text: 'Setting', icon: Icons.settings_outlined),*/
                  const Divider(),
                 /* CustomListTile(
                      onTap: () {
                        Get.to(()=>const FeedbackWidget());
                      },
                      text: 'Feedback',
                      icon: Icons.feedback_outlined),
                  const Divider(),*/
                  CustomListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(()=>const HelpScreen());
                      },
                      text: 'Help',
                      icon: Icons.help_outline_outlined),
                  const Divider(),
                  CustomListTile(
                      onTap: ()async {
                        Navigator.pop(context);
                        bool status = await controller.getContactUsNetworkApi();
                        if(status == true){
                          Get.to(()=> const ContactUs());
                        }
                      },
                      text: 'Contact Us',
                      icon: Icons.person_pin_outlined),
                  const Divider(),
                  SizedBox(height: 200.r),
                  const Divider(color: Colors.red,),
                  CustomListTile(
                      onTap: () async {
                        Navigator.pop(context);
                        logoutAlertBox(context);
                      },
                      text: 'Logout', icon: Icons.logout,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void logoutAlertBox(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => Dialog(
        alignment: Alignment.center,
        insetPadding: EdgeInsets.symmetric(horizontal: 25.0.w,),
        backgroundColor: TColor.lightGrey.withAlpha(150),
        child: WillPopScope(
          onWillPop:Future.value,
          child: Container(
            height: 170.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20..w, vertical: 10.0.h),
            width: double.infinity,
            decoration: BoxDecoration(
                color: TColor.lightGrey,
                borderRadius: BorderRadius.circular(5.0.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Logout !",
                  style: robotoText.copyWith(
                    fontSize: 20.sp
                        , color: Colors.red
                  ),textAlign:TextAlign.center
                ),
                SizedBox(
                    height: 20.h
                ),
                Text(
                  "Are you sure, do you want to logout?\n"
                      "please press Yes otherwise No !!",
                  style: robotoText.copyWith(fontSize: 15.sp, height: 1.3),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Card(
                        color: TColor.themecolor,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25.r)
                       ),
                        child: Padding(
                          padding:  EdgeInsets.only(left:18.r,right: 18.r,top: 9.r,bottom: 9.r),
                          child: Text("Cancel",style: robotoRegular.copyWith(
                          color: Colors.white,
                            fontSize: 15.sp,
                          )),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        GetStorage().erase();
                        controller.removeData();
                        Get.delete<LoginController>();
                        Get.offAll(()=>const SpalshScreen());
                      },
                      child: Card(
                        color: TColor.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left:18.r,right: 18.r,top: 9.r,bottom: 9.r),
                          child: Text("Logout",style: robotoRegular.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                          )),
                        ),
                      ),
                    ),
                    // MaterialButton(
                    //   onPressed: () {
                    //     Get.back();
                    //   },
                    //   shape: const RoundedRectangleBorder(
                    //       borderRadius:
                    //       BorderRadius.all(Radius.circular(5))),
                    //   color: Colors.green.shade500,
                    //   child: Text("No",
                    //       style: robotoRegular.copyWith(
                    //         color: Colors.white,
                    //         fontSize: 15.sp,
                    //       )),
                    // ),
                    // const Spacer(),
                    // MaterialButton(
                    //   onPressed: () {
                    //     GetStorage().erase();
                    //     controller.removeData();
                    //     Get.delete<LoginController>();
                    //     Get.offAll(()=>const SpalshScreen());
                    //   },
                    //   shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(5))),
                    //   color: Colors.red.shade400,
                    //   child: Text("Yes",
                    //       style: robotoRegular.copyWith(
                    //         color: Colors.white,
                    //         fontSize: 15.sp,
                    //       )),
                    // )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
