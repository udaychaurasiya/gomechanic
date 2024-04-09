// ignore_for_file: file_names, avoid_print

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/CircularButton.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/EditTextWedget.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

import '../controller/details_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}
class _RegistrationScreenState extends State<RegistrationScreen> {
    final formKey = GlobalKey<FormState>();
    final LoginController controller = Get.put(LoginController());
    final DetailsController _controller=Get.put(DetailsController());


    @override
  void initState() {
     controller.getAddressFromLatLong();
     _controller.UpdateAddressNetWorkApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    controller.etAddress.text = controller.current_address.value.toString();
    double  width;
    width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child:  Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 20.0.w,bottom: 20.0.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h,),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        height: 70.0.h,
                        width: 70.0.w,
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
                          repeatForever: true,

                        ),
                      )
                    ],
                  ),
                  Text(
                    'Create an Account',
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeOverLarge),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.w),
                    child: Row(
                      children: [
                        Expanded(
                            child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 15.0.h),
                              EditTextWidget(
                                hint: 'Name',
                                label: const Text('Name'),
                                controller: controller.etName,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please Enter Name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10.0.h),
                              EditTextWidget(
                                hint: 'Mobile',
                                label: const Text('Mobile'),
                                type: TextInputType.phone,
                                controller: controller.number,
                                isRead: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Allow only digits
                                ],
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please enter mobile";
                                  }
                                  if (value.toString().length != 10) {
                                    return "Please enter 10 digit Number";
                                  }
                                  return null;
                                },
                                length: 10,
                              ),
                              Obx(() => DropdownButtonFormField(
                                    isExpanded: true,
                                    alignment: Alignment.center,
                                    value: controller.idProveType.value,
                                    decoration: InputDecoration(
                                      hintText: 'Select ID Type',
                                      label: const Text('Select ID Option'),
                                      hintStyle: robotoRegular.copyWith(
                                          color: TColor.black.withAlpha(150)),
                                      labelStyle: robotoRegular.copyWith(
                                          color: TColor.black.withAlpha(150)),
                                      enabledBorder:  UnderlineInputBorder(
                                        borderSide: BorderSide(color: TColor.lightGrey.withAlpha(150), width: 0.5.w),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: TColor.black),
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 0,
                                        child: Text(
                                          'Select Card Type',
                                          style: robotoRegular.copyWith(
                                              color: TColor.black.withAlpha(150)),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text(
                                          'Aadhaar Card',
                                          style: robotoRegular.copyWith(
                                              color: TColor.black.withAlpha(150)),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text(
                                          'Voter ID',
                                          style: robotoRegular.copyWith(
                                              color: TColor.black.withAlpha(150)),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 3,
                                        child: Text(
                                          'Driving Licence',
                                          style: robotoRegular.copyWith(
                                              color: TColor.black.withAlpha(150)),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 4,
                                        child: Text(
                                          'Passport',
                                          style: robotoRegular.copyWith(
                                              color: TColor.black.withAlpha(150)),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      controller.idProveType.value = value as int;
                                      print(controller.idProveType.value);
                                    },
                                    validator: (value) {
                                      if (controller.idProveType.value == 0) {
                                        return "Please select your card";
                                      }
                                      return null;
                                    },
                                  ),
                              ),
                              SizedBox(height: 15.0.h),
                              Obx(() =>controller.idProveType.value == 1 || controller.idProveType.value == 0
                                ? EditTextWidget(
                                    hint: controller.idProveType.value == 0
                                        ? 'Select Card' : 'Aadhaar Number',
                                    controller: controller.etAadhar,
                                    label: Text(controller.idProveType.value == 0
                                        ? 'Select Card' : 'Aadhaar Number'),
                                    type: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Allow only digits
                                    ],
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please enter Aadhaar Number";
                                      }
                                      if (value.toString().length != 12) {
                                        return "Please enter 12 digit Number";
                                      }
                                      return null;
                                    },
                                    length: 12,
                                  )
                                  : controller.idProveType.value == 2
                                  ? EditTextWidget(
                                    hint: 'Voter ID',
                                    controller: controller.etAadhar,
                                    label: const Text('Voter ID'),
                                    type: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Allow only digits
                                    ],
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Voter ID Number";
                                      }
                                      if (value.toString().length != 12) {
                                        return "Please Enter Voter ID Number";
                                      }
                                      return null;
                                    },
                                  )
                                  : controller.idProveType.value == 3
                                  ? EditTextWidget(
                                    hint: "Driving Licence",
                                    controller: controller.etAadhar,
                                    label: const Text("Driving Licence"),
                                    type: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Allow only digits
                                    ],
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Driving Licence Number";
                                      }
                                      if (value.toString().length != 12) {
                                        return "Please Enter Driving Licence Number";
                                      }
                                      return null;
                                    },
                                  )
                                  : EditTextWidget(
                                    hint: "Passport",
                                    controller: controller.etAadhar,
                                    label: const Text("Passport"),
                                    type: TextInputType.phone,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Allow only digits
                                    ],
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "Please Enter Passport Number";
                                      }
                                      if (value.toString().length != 12) {
                                        return "Please Enter Passport Number";
                                      }
                                      return null;
                                    },
                                  )
                              ),
                              SizedBox(height: 10.0.h),
                              EditTextWidget(
                                hint: 'Email',
                                label: const Text('Email'),
                                controller: controller.etEmail,
                                type: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please Enter Email";
                                  }
                                  if (!GetUtils.isEmail(value)) {
                                    return "Please Enter Valid Email";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10.0.h
                              ),
                              EditTextWidget(
                                hint: 'Address',
                                isRead: true,
                                controller: controller.etAddress,
                                type: TextInputType.text,
                                label: const Text('Address'),
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Please enter address details";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CircularButton(onPress: () async{
                                    if (formKey.currentState!.validate()) {
                                    bool status = await controller.registrationNetworkApi(true);
                                    if(status == true){
                                      controller.shopName.clear();
                                      controller.startTime.clear();
                                      controller.endTime.clear();
                                      controller.description.clear();
                                      controller.serviceCapacity.clear();
                                      controller.shopPath.value = "";
                                      controller.shopImage.value = "";
                                      controller.normalCc.value = 0;
                                      controller.highPickup.value = 0;
                                      controller.roadService.value = 0;
                                    }
                                  }},),
                                ],
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 35.0.h),
                  SizedBox(height: 80.0.h)
                ],
              ),
            ),
          ),
      ),
    );
  }
}
