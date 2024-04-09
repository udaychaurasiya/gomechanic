// ignore_for_file: unnecessary_null_comparison, file_names

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/CircularButton.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/controller/notification_service.dart';
import 'package:gomechanic/utils/all_image.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

NotificationServices notificationServices = NotificationServices();

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = Get.put(LoginController());
  late String deviceId = "";

  @override
  void initState() {
    super.initState();
    // notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.FcmToken();
    // notificationServices.getDeviceToken().then((value) {
    //   if (kDebugMode) {
    //     _controller.FCM_TOKEN.value = value;
    //     print('device token key ======>>>>>>>>>  ${_controller.FCM_TOKEN.value}');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: const Color(0xffffffff),
            body: Container(
              margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w, top: 25.0.h),
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50.h,),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200.0.h,
                          width: 280.0.w,
                          alignment: Alignment.center,
                          child: Image.asset(
                            Images.login.toString(),
                            height: 240.0.h,
                            width: 250.0.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Create an Account',
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge,
                        color: TColor.themecolor,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Enter your mobile number with country code",
                            style: robotoText.copyWith(fontSize: Dimensions.fontSizeDefault2),
                          ),
                        )),
                     SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              readOnly: true,
                              initialValue: "+91",
                              style: titleStyle,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                isDense: true,
                              ),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            flex: 5,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _controller.etMobile,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  counter: Offstage(),
                                  hintText: "0000000000",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Allow only digits
                                ],
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please enter mobile No.";
                                  }
                                  if (value!.length < 10) {
                                    return 'Please enter 10 digit number';
                                  }
                                  return null;
                                },
                                maxLength: 10,
                                style: titleStyle,
                              ),
                            )),
                        SizedBox(width: 20.w),
                        Expanded(
                          flex: 2,
                          child: CircularButton(
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                _controller.loginNetworkApi();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: RoundedLoadingButton(
                        onPressed: () async
                          {
                            bool status = await _controller.socialGoogleLogin();
                            if(status == true) {
                              _controller.socialSignInUpNetworkApi(deviceId);
                            }
                        },
                        controller: _controller.googleController,
                        successColor: Colors.red,
                        width: MediaQuery.of(context).size.width * 0.60,
                        height: 40.0.h,
                        elevation: 0,
                        borderRadius: 30,
                        color: TColor.themecolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Images.google,height: 30.0.h, width: 30.0.w),
                            SizedBox(width: 15.w),
                            Text("Sign in with Google",
                                style: TextStyle(
                                    color: TColor.white,
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0.h),
                    Padding(
                      padding:  const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.center,
                          padding:  EdgeInsets.only(bottom: 10.h),
                          child: Text.rich(
                            TextSpan(
                              style: smallTextStyle,
                              children: const [
                                TextSpan(
                                  text:
                                  'By signing in or creating an account, you agree with our \n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      height: 2,
                                      letterSpacing: 0.2),
                                ),
                                TextSpan(
                                  text: 'Term and conditions',
                                  style: TextStyle(
                                    color: Color(0xff006eff),
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: Color(0xff006eff),
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                    color: Color(0xff006eff),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior:
                            const TextHeightBehavior(applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                            softWrap: false,
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
