// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, file_names, avoid_print, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/EditTextWedget.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/helper/custom_dialog.dart';
import 'package:gomechanic/utils/all_image.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:photo_view/photo_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  var email = "".obs;

  @override
  void initState() {
    super.initState();
    controller.shopOpenCloseNetworkApi();
  }

  @override
  Widget build(BuildContext context) {
    var data = controller.shopOpenClose.value.data;
    controller.number.text = data.mobile ?? "";
    controller.etName.text = data.name ?? "";
    controller.etEmail.text = data.email ?? "";
    controller.etAddress.text = data.address ?? "";
    controller.profile.value = data.profile ?? "";
    controller.idProveType.value = data.idProveType.toString().isNotEmpty
        ? int.parse(data.idProveType ?? "0")
        : 0;
    controller.etAadhar.text = data.idProveNo ?? "";
    return WillPopScope(
      onWillPop: () async {
        await Get.to(()=> const DashboardScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: TColor.themecolor,
          leading: IconButton(
              onPressed: () => Get.to(() => const DashboardScreen()),
              icon: Icon(
                Icons.arrow_back,
                size: 22.sp,
              )),
          title: Text(
            "Profile Details",
            style:
                bodyText1Style.copyWith(fontSize: 19.sp, color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xffffffff),
        body: Container(
          margin: const EdgeInsets.only(right: 0, top: 20),
          child: Obx(
            () => FadeInUp(
              delay: const Duration(milliseconds: 350),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Stack(children: [
                        InkWell(
                          onTap: () => bottomSheet(context),
                          child: controller.rxPath.isEmpty
                              ? Container(
                                  height: 110.0,
                                  width: 110.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0.w,
                                          color: TColor.themecolor
                                              .withOpacity(0.5)),
                                      borderRadius:
                                          BorderRadius.circular(100.0.r),
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
                                              AppConstants.BASE_URL +
                                                  controller.profile.value
                                                      .toString()),
                                          fit: BoxFit.fill)),
                                )
                              : Container(
                                  height: 110.0,
                                  width: 110.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0.w,
                                          color: TColor.themecolor
                                              .withOpacity(0.5)),
                                      borderRadius:
                                          BorderRadius.circular(100.0.r),
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(controller.rxPath.value)),
                                          fit: BoxFit.fill)),
                                  child: Obx(() => controller.isLoading.value
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator())
                                      : const SizedBox()),
                                ),
                        ),
                        Positioned(
                          bottom: 3.0,
                          right: 3.0,
                          child: InkWell(
                            onTap: () => bottomSheet(context),
                            child: CircleAvatar(
                              radius: 16.0.r,
                              backgroundColor: TColor.themecolor.withAlpha(250),
                              child: Icon(
                                Icons.image_outlined,
                                size: 19.0.sp,
                                color: TColor.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 10,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    SizedBox(height: 8.0.h),
                                    EditTextWidget(
                                      hint: 'Mobile',
                                      label: const Text('Mobile'),
                                      type: TextInputType.phone,
                                      controller: controller.number,
                                      isRead: false,
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
                                    DropdownButtonFormField(
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      value: controller.idProveType.value,
                                      decoration: InputDecoration(
                                        hintText: 'Select ID Card',
                                        label: const Text("Select an option"),
                                        labelStyle: robotoRegular.copyWith(
                                            color: TColor.black.withAlpha(150),
                                            fontSize:
                                                Dimensions.fontSizeDefault),
                                        hintStyle: robotoMedium.copyWith(
                                            color: TColor.black.withAlpha(180)),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: TColor.lightGrey
                                                  .withAlpha(150),
                                              width: 0.5.w),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: TColor.black),
                                        ),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text(
                                            'Select Card Type',
                                            style: robotoMedium.copyWith(
                                                color: TColor.black
                                                    .withAlpha(180)),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text(
                                            'Aadhar Card',
                                            style: robotoMedium.copyWith(
                                                color: TColor.black
                                                    .withAlpha(180)),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text(
                                            'Voter ID',
                                            style: robotoMedium.copyWith(
                                                color: TColor.black
                                                    .withAlpha(180)),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 3,
                                          child: Text(
                                            'Driving Licence',
                                            style: robotoMedium.copyWith(
                                                color: TColor.black
                                                    .withAlpha(180)),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 4,
                                          child: Text(
                                            'Passport',
                                            style: robotoMedium.copyWith(
                                                color: TColor.black
                                                    .withAlpha(180)),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        controller.idProveType.value = value!;
                                        print(controller.idProveType.value);
                                      },
                                      validator: (value) {
                                        if (controller.idProveType.value == 0) {
                                          return "Please select your card";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 10.0.h),
                                    // EditTextWidget(
                                    //     hint: controller.idProveType.value ==
                                    //             0
                                    //         ? 'Select Card'
                                    //         : controller.idProveType.value ==
                                    //                 1
                                    //             ? 'Aadhaar Number'
                                    //             : controller.idProveType
                                    //                         .value ==
                                    //                     2
                                    //                 ? 'Voter ID'
                                    //                 : controller.idProveType
                                    //                             .value ==
                                    //                         3
                                    //                     ? 'Driving Licence'
                                    //                     : "Passport",
                                    //     label: Text(controller
                                    //                 .idProveType.value ==
                                    //             0
                                    //         ? 'Select Card'
                                    //         : controller.idProveType.value ==
                                    //                 1
                                    //             ? 'Aadhaar Number'
                                    //             : controller.idProveType
                                    //                         .value ==
                                    //                     2
                                    //                 ? 'Voter ID Number'
                                    //                 : controller.idProveType
                                    //                             .value ==
                                    //                         3
                                    //                     ? 'Driving Licence Number'
                                    //                     : "Passport Number"),
                                    //     controller: controller.etAadhar,
                                    //     type: TextInputType.phone,
                                    //     inputFormatters: [
                                    //       FilteringTextInputFormatter
                                    //           .digitsOnly, // Allow only digits
                                    //     ],
                                    //     validator: (value) {
                                    //       if (value.toString().isEmpty) {
                                    //         return "Please enter Aadhar Number";
                                    //       }
                                    //       if (value.toString().length != 12) {
                                    //         return "Please enter 10 digit Number";
                                    //       }
                                    //       return null;
                                    //     },
                                    //     length: 12,
                                    //   ),
                                    Obx(() => controller.idProveType.value ==
                                                1 ||
                                            controller.idProveType.value == 0
                                        ? EditTextWidget(
                                            hint:
                                                controller.idProveType.value ==
                                                        0
                                                    ? 'Select Card'
                                                    : 'Aadhaar Number',
                                            controller: controller.etAadhar,
                                            label: Text(
                                                controller.idProveType.value ==
                                                        0
                                                    ? 'Select Card'
                                                    : 'Aadhaar Number'),
                                            type: TextInputType.text,
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return "Please enter Aadhaar Number";
                                              }
                                              if (value.toString().length !=
                                                  12) {
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
                                                type: TextInputType.text,
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .isEmpty) {
                                                    return "Please Enter Voter ID Number";
                                                  }
                                                  if (value.toString().length !=
                                                      12) {
                                                    return "Please Enter Voter ID Number";
                                                  }
                                                  return null;
                                                },
                                              )
                                            : controller.idProveType.value == 3
                                                ? EditTextWidget(
                                                    hint: "Driving Licence",
                                                    controller:
                                                        controller.etAadhar,
                                                    label: const Text(
                                                        "Driving Licence"),
                                                    type: TextInputType.text,
                                                    validator: (value) {
                                                      if (value
                                                          .toString()
                                                          .isEmpty) {
                                                        return "Please Enter Driving Licence Number";
                                                      }
                                                      if (value
                                                              .toString()
                                                              .length !=
                                                          12) {
                                                        return "Please Enter Driving Licence Number";
                                                      }
                                                      return null;
                                                    },
                                                  )
                                                : EditTextWidget(
                                                    hint: "Passport",
                                                    controller:
                                                        controller.etAadhar,
                                                    label:
                                                        const Text("Passport"),
                                                    type: TextInputType.text,
                                                    validator: (value) {
                                                      if (value
                                                          .toString()
                                                          .isEmpty) {
                                                        return "Please Enter Passport Number";
                                                      }
                                                      if (value
                                                              .toString()
                                                              .length !=
                                                          12) {
                                                        return "Please Enter Passport Number";
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                    SizedBox(height: 8.0.h),
                                    EditTextWidget(
                                      hint: 'Email',
                                      label: const Text('Email'),
                                      controller: controller.etEmail,
                                      type: TextInputType.emailAddress,
                                      validator: (value) {
                                        email.value = value;
                                        if (value.toString().isEmpty) {
                                          return "Please Enter Email";
                                        }
                                        if (!GetUtils.isEmail(value)) {
                                          return "Please Enter Valid Email";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 8.0.h),
                                    EditTextWidget(
                                      hint: 'Address',
                                      label: const Text('Address'),
                                      controller: controller.etAddress,
                                      type: TextInputType.text,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please enter your address";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 50.0.h),
                                    Container(
                                      height: 40.0.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: TColor.themecolor,
                                        borderRadius:
                                            BorderRadius.circular(5.0.r),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            elevation: 0.0),
                                        onPressed: () async {
                                          if (formKey.currentState!.validate()) {
                                            controller.registrationNetworkApi(false);
                                          }
                                        },
                                        child: Text('Update Details',
                                            style: robotoMedium.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              color: TColor.white,
                                              decoration: TextDecoration.none,
                                            )),
                                      ),
                                    ),
                                    /*InkWell(
                                              onTap: () =>
                                                  Navigator.pushNamed(context, RouteHelper.shopDetails),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.0.w),
                                                child: Text(
                                                  'Shop Details Edit',
                                                  style: robotoMedium.copyWith(
                                                      fontSize:
                                                          Dimensions.fontSizeLarge,
                                                      color: TColor.Text),
                                                ),
                                              )),*/
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> bottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 180.0.h,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 3.0.h,
                  width: 50.0.w,
                  margin: const EdgeInsets.only(top: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black26,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.chooseImage(true);
                        Get.back();
                      },
                      child: Container(
                        height: 90.0.h,
                        width: 90.0.w,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1.0.w, color: Colors.grey.shade400)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0.w,
                                      color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        Images.camera,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              'Camera',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.chooseImage(false);
                        Get.back();
                      },
                      child: Container(
                        height: 90.0.h,
                        width: 90.0.w,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1.0.w, color: Colors.grey.shade400)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0.w,
                                      color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        Images.gallery,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => showAnimation(context),
                      child: Container(
                        height: 90.0.h,
                        width: 90.0.w,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1.0.w, color: Colors.grey.shade400)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.rxPath.isEmpty
                                ? Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0.w,
                                          color: TColor.grey),
                                      borderRadius: BorderRadius.circular(100.0.r),
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
                                              AppConstants.BASE_URL +
                                                  controller.profile.value
                                                      .toString()),
                                          fit: BoxFit.fill)),
                                )
                                : Container(
                                  height: 60.0,
                                  width: 60.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0.w,
                                          color: TColor.grey),
                                      borderRadius:
                                      BorderRadius.circular(100.0.r),
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(controller.rxPath.value)),
                                          fit: BoxFit.fill)),
                                  child: Obx(() => controller.isLoading.value
                                      ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator())
                                      : const SizedBox()),
                            ),
                            Text(
                              'View',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showAnimation(BuildContext context) {
    Navigator.pop(context);
    return showAnimatedDialog(
        context,
        Center(
          child: Container(
            width: 350.w,
            height: 350.h,
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
                color: Theme.of(Get.context!).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                border: Border.all(
                    width: 1.0.w,
                    color: TColor.themecolor
                        .withOpacity(0.5)),
            ),
            child: controller.rxPath.isEmpty
                ? SizedBox(
                  height: 110.0,
                  width: 110.0,
                  child: PhotoView(
                      minScale: PhotoViewComputedScale.contained * 0.9,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    imageProvider: NetworkImage(
                      AppConstants.BASE_URL +
                          controller.profile.value
                              .toString()),
                    filterQuality: FilterQuality.high,
                    backgroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                    ),
                  ),
                )
                : Container(
                  height: 110.0,
                  width: 110.0,
                  alignment: Alignment.center,
                  child: PhotoView(
                      minScale: PhotoViewComputedScale.contained * 0.9,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      imageProvider: FileImage(
                      File(controller.rxPath.value)),
                      backgroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                      )
                      ,filterQuality: FilterQuality.high),
                ),
              ),
        ),
        dismissible: true);
  }
}
