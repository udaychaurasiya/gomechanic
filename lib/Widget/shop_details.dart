// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/CoustomButton.dart';
import 'package:gomechanic/Widget/EditTextWedget.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> Get.to(()=> const DashboardScreen()), icon: Icon(Icons.arrow_back, size: 22.sp,)),
        elevation: 0,
        backgroundColor: TColor.themecolor,
        title: Text(
          "Shop Details",
          style: bodyText1Style.copyWith(fontSize: 19.sp, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 0, top: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  EditTextWidget(
                    hint: 'Shop Name',
                    label: const Text('Shop Name'),
                    controller: controller.shopName,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter shop name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0.h),
                //   DropdownButtonFormField(
                //    itemHeight: 50.r,
                //     isExpanded: true,
                //     items: ["Select Vehicle", "Two wheeler", "Four Wheeler", "both two wheeler and four wheeler", "Other"].map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value,style: TextStyle(fontSize: 14.r),),
                //         onTap: () {
                //           print("value $value");
                //           controller.selectvehicle.value = value;
                //         },
                //       );
                //     }).toList(),
                //     value: controller.selectvehicle.value, // Set the default value here
                //     onChanged: (String? newValue) {
                //       controller.selectvehicle.value = newValue ?? "Select Vehicle";
                //     },
                //   decoration: InputDecoration(
                //     hintText: "hint",
                //
                //     hintStyle: TextStyle(
                //       wordSpacing: 0.2.r,
                //       letterSpacing: 0.8.r,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.grey.withOpacity(0.7),
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //     labelStyle: TextStyle(
                //       wordSpacing: 0.2.r,
                //       letterSpacing: 0.8.r,
                //       fontSize: 14.r,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.black.withOpacity(0.7),
                //     ),
                //     contentPadding:  EdgeInsets.symmetric(horizontal: 6.r, vertical: 10.r),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //           color: Colors.grey.withOpacity(0.3), width: .5.r),
                //     ),
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey, width: 0.5.r),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black, width: .5.r),
                //     ),
                //   ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please Select Vehicle';
                //       }
                //       return null;
                //     },
                // ),
                  DropdownButtonFormField(
                    itemHeight: 50.r,
                    isExpanded: true,
                    items: [
                      "Select Vehicle",
                      "Two wheeler",
                      "Four Wheeler",
                      "both two wheeler and four wheeler",
                      "Other",
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 14.r)),
                        onTap: () {
                          print("value $value");
                          controller.selectvehicle.value = value;

                          if (value == "Other") {
                            controller.showOtherTextField.value = true;
                          } else {
                            controller.showOtherTextField.value = false;
                          }
                        },
                      );
                    }).toList(),
                    value: controller.selectvehicle.value, // Set the default value here
                    onChanged: (String? newValue) {
                      controller.selectvehicle.value = newValue ?? "Select Vehicle";

                      // Check if "Other" is selected and open a new TextField
                      if (newValue == "Other") {
                        controller.showOtherTextField.value = true;
                      } else {
                        controller.showOtherTextField.value = false;
                      }
                    },
                    decoration: InputDecoration(
                      // Your existing decoration properties
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || (value == "Other" && controller.otherValueController.text.isEmpty)) {
                        return 'Please Select Vehicle or enter a value for Other';
                      }
                      return null;
                    },
                  ),

                 SizedBox(height: 20.h,),
                  Obx(() {
                    if (controller.showOtherTextField.value) {
                      return TextField(
                        controller: controller.otherValueController, // Assuming you have a TextEditingController for Other
                        decoration: InputDecoration(
                          hintText: "Enter Other Vehicle",
                          // Add your other styling properties here
                        ),
                      );
                    } else {
                      return SizedBox.shrink(); // Return an empty widget if Other is not selected
                    }
                  }),

                  SizedBox(height: 10.0.h),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextWidget(
                          hint: 'Open Time',
                          label: const Text('Open Time'),
                          controller: controller.startTime,
                          type: TextInputType.text,
                          onTap: () async {
                            controller.chooseTime(false);
                          },
                          isRead: true,
                          suffixIcon: InkWell(
                            onTap: () async {
                              controller.chooseTime(false);
                            },
                            child: Icon(Icons.access_time,
                                color: TColor.black.withAlpha(100)),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Please enter open time";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 40.0.w),
                      Expanded(
                        child: EditTextWidget(
                          hint: 'End Time',
                          label: const Text('End Time'),
                          controller: controller.endTime,
                          type: TextInputType.text,
                          onTap: () async {
                            controller.chooseTime(true);
                          },
                          isRead: true,
                          suffixIcon: InkWell(
                            onTap: () async {
                              controller.chooseTime(true);
                            },
                            child: Icon(Icons.access_time,
                                color: TColor.black.withAlpha(100)),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Please enter close time";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                 /* SizedBox(height: 10.0.h),
                  EditTextWidget(
                    hint: 'Description',
                    label: const Text('Description'),
                    controller: controller.description,
                    type: TextInputType.multiline,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter shop description";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5.0.h),
                  EditTextWidget(
                    hint: 'Service Capacity No',
                    label: const Text('Service Capacity No'),
                    controller: controller.serviceCapacity,
                    type: TextInputType.number,
                    length: 4,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter cycle service capacity number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Normal CC      :',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault)),
                      Obx(
                          () => Radio(
                          value: 1,
                          groupValue: controller.normalCc.value,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            controller.normalCc.value = value!;
                          },
                        ),
                      ),
                      Text('Yes',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: TColor.black.withAlpha(150))),
                      Obx(
                            () => Radio(
                          value: 0,
                          groupValue: controller.normalCc.value,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            controller.normalCc.value = value!;
                            print(controller.normalCc.value);
                          },
                        ),
                      ),
                      Text('No',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: TColor.black.withAlpha(150))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('High Pickup    :',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault)),
                      Obx(() => Radio(
                          value: 1,
                          groupValue: controller.highPickup.value,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            controller.highPickup.value = value!;
                          },
                        ),
                      ),
                      Text('Yes',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: TColor.black.withAlpha(150))),
                      Obx(
                            () => Radio(
                          value: 0,
                          groupValue: controller.highPickup.value,
                          activeColor: Colors.red,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: (value) {
                            controller.highPickup.value = value!;
                            print(controller.highPickup.value);
                          },
                        ),
                      ),
                      Text('No',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: TColor.black.withAlpha(150))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Road Service  :',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault)),
                      // SizedBox(width: 5.0.w),
                      Obx(
                            () => Radio(
                          value: 1,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          groupValue: controller.roadService.value,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            controller.roadService.value = value!;
                          },
                        ),
                      ),
                      Text('Yes',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: TColor.black.withAlpha(150))),
                      // SizedBox(width: 5.0.w),
                      Obx(
                            () => Radio(
                          value: 0,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          groupValue: controller.roadService.value,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            controller.roadService.value = value!;
                            print(controller.roadService.value);
                          },
                        ),
                      ),
                      Text(
                        'No',
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: TColor.black.withAlpha(150)),
                      ),
                    ],
                  ),*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Shop Photo     :',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault)),
                      SizedBox(width: 15.0.w),
                      MaterialButton(
                        onPressed: () {
                          controller.chooseShopImage();
                        },
                        elevation: 0.0,
                        height: 30.0.h,
                        minWidth: 100.0.w,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r)),
                        color: TColor.lightGrey,
                        child: Text(
                          'Choose',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Colors.black45),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0.h),
                  Obx(() => Container(
                          height: 120.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0.w,
                                  color: TColor.lightGrey),
                              borderRadius: BorderRadius.circular(5.0.r),
                              image: DecorationImage(
                                  image: FileImage(
                                      File(controller.shopPath.value)),
                                  fit: BoxFit.cover)),
                          child: Obx(
                                () => controller.isLoading.value
                                ? CircularProgressIndicator(
                                color: TColor.grey)
                                : const SizedBox(),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0.h),
                  CustomButton(onPress: () async{
                    if (controller.formKey.currentState!.validate()) {
                      bool status = await controller.updateShopProfile("Login Successfully!");
                      if (status == true) {
                        Get.offAll(() => const DashboardScreen());
                      }
                    }
                  }, title: 'Submit',)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
