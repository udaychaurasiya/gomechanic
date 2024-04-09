// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/CoustomButton.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerify extends StatefulWidget {
  final String id;
  final String otp;
  const OtpVerify({Key? key, required this.id, required this.otp})
      : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final LoginController _controller = Get.put(LoginController());

  @override
  void initState() {
    _controller.resetTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    RxString verifyOtp = "".obs;
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.0.h),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: const Icon(Icons.clear)),
                    Text("Verify ",style: titleStyle,)
                  ],
                )
              ),
              SizedBox(
              height: 240.h,
              width: Get.width,
                child: Image.asset("assets/images/veryfy.png"),
                
              ),
              Text(
                "Enter the verification code we just sent\nyou on your",
                style: smallTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 5.0),
                    child: Text(
                      "Code",
                      style: titleStyle.copyWith(
                          fontSize: 18.0.sp, color: Colors.black38),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 150.0.w,
                    height: 40.0.h,
                    child: Form(
                      // key: _formKey,
                      child: OTPTextField(
                        length: 4,
                        controller: _controller.otpController,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 30.0.w,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          // Allow only digits
                        ],
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        onChanged: (value) {
                          verifyOtp.value = value;
                        },
                        onCompleted: (pin) {
                          verifyOtp.value = pin;
                          _controller.verifyNetworkApi(widget.id, pin);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 50, right: 15, bottom: 40),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => Text(
                        DateFormat('mm').format(
                            DateTime(0, 0, 0, 0, _controller.seconds.value)),
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault2,
                            decoration: TextDecoration.underline,
                            color: const Color(0xff051ba6)),
                      ),
                    ),
                    SizedBox(width: 8.0.w),
                    InkWell(
                      onTap: () {
                        if (_controller.seconds.value == 00) {
                          _controller.resetTimer();
                          _controller.loginNetworkApi();
                        }
                      },
                      child: Obx(() => Text(
                            "Resend Code?",
                            style: titleStyle.copyWith(
                                fontSize: 16.0.sp,
                                decoration: TextDecoration.underline,
                                color: _controller.seconds.value != 00
                                    ? Colors.grey.shade300
                                    : Colors.blue),
                          )),
                    )
                  ],
                ),
              ),
              CustomButton(
                onPress: () async{
                  if(verifyOtp.value.isEmpty){
                    CustomAnimation().showCustomToast("Please fill four digit number");
                  }else{
                    bool status = await _controller.verifyNetworkApi(widget.id, verifyOtp.value);
                    if(status == true){
                      _controller.getAddressFromLatLong();
                      // _controller.currentAddressNetworkApi();
                    }
                  }
                },
                title: "Verify Code",
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.startTimer;
    super.dispose();
  }
}
