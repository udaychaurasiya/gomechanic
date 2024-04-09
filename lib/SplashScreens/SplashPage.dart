// ignore_for_file: file_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/SplashScreens/LoginPage.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/all_image.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return AnimatedSplashScreen(
      splash: Stack(children: [
        controller.isLoading.value
            ? Center(child: CircularProgressIndicator(color: TColor.grey))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.splash,
                      height: 280.0.h,
                      width: 300.0.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(
                                'RepairDo',
                                textStyle:  TextStyle(
                                  fontSize: 30.sp,
                                  color:  TColor.themecolor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                            onTap: (){},
                            isRepeatingAnimation: true,
                            totalRepeatCount: 100,
                            repeatForever: true,

                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ]),
      backgroundColor: Colors.white,
      nextScreen: const LoginPage(),
      splashIconSize: 450.h,
    );
  }
}
