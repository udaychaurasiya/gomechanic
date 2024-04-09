// ignore_for_file: deprecated_member_use, file_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/all_image.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    controller.getContactUsNetworkApi();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.to(()=> const DashboardScreen());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () => Get.to(() => const DashboardScreen()),
                icon: Icon(
                  Icons.arrow_back,
                  size: 22.sp,
                )),
            backgroundColor: TColor.themecolor,
            title: Text(
              "Contact Us",
              style: robotoMedium.copyWith(
                  fontSize: Dimensions.fontSizeLarge, color: Colors.white),
            ),
            leadingWidth: 30.w,
          ),
          body: SingleChildScrollView(
            child: Obx(() => controller.contactUs.value.data
                    .toString()
                    .isNotEmpty
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.0.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                            height: 120.r,
                              width: 120.r,
                              child: Image.asset("assets/images/log.png"),
                            ),
                            DefaultTextStyle(
                              style:  TextStyle(
                                fontSize: 20.r,
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  WavyAnimatedText(
                                    'RepairDo',
                                    textStyle:  TextStyle(
                                      fontSize: 30.sp,
                                      color:  const Color(0xff051ba6),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                                onTap: (){},
                                isRepeatingAnimation: true,
                                totalRepeatCount: 100,
                                stopPauseOnTap: true,
                                repeatForever: true,

                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15.r,),
                        InkWell(
                          onTap:controller.launchCaller,
                          child: Container(
                            height: 40.0.h,
                            color: TColor.themecolor.withAlpha(20),
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_forwarded_outlined,
                                  color: TColor.Text,
                                ),
                                SizedBox(width: 20.0.w),
                                Text(
                                  controller.contactUs.value.data.mobile
                                      .toString(),
                                  style: robotoText.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0.h),
                        InkWell(
                          onTap: controller.luncherMail,
                          child: Container(
                            height: 40.0.h,
                            color: TColor.themecolor.withAlpha(20),
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: TColor.Text,
                                ),
                                SizedBox(width: 20.0.w),
                                Text(
                                  controller.contactUs.value.data.email
                                      .toString(),
                                  style: robotoText.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0.h),
                        InkWell(
                          onTap: () {
                            double latitude = 26.800150224926202;
                            double longitude = 80.8975398281861;
                            controller.openGoogleMaps(latitude, longitude);
                          },
                          child: Container(
                            height: 40.0.h,
                            color: TColor.themecolor.withAlpha(20),
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: TColor.Text,
                                ),
                                SizedBox(width: 20.0.w),
                                Text(
                                  controller.contactUs.value.data.address
                                      .toString(),
                                  style: robotoText.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0.h),
                        InkWell(
                          onTap: controller.websiteLink,
                          child: Container(
                            height: 40.0.h,
                            color: TColor.themecolor.withAlpha(20),
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.public_outlined,
                                  color: TColor.Text,
                                ),
                                SizedBox(width: 20.0.w),
                                Text(
                                  "animation media website",
                                  style: robotoText.copyWith(
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: controller.facebookUrlApp,
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundImage:
                                    const AssetImage(Images.facebook),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            InkWell(
                              onTap: controller.instagramUrlApp,
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundImage:
                                    const AssetImage(Images.instagram),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            InkWell(
                              onTap: controller.twitterUrlApp,
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundImage:
                                    const AssetImage(Images.twitter),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container()),
          )),
    );
  }
}
