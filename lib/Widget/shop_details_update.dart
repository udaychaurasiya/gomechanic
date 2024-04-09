// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/CoustomButton.dart';
import 'package:gomechanic/Widget/EditTextWedget.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/helper/custom_dialog.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:photo_view/photo_view.dart';

class ShopDetailsUpdate extends StatefulWidget {
  const ShopDetailsUpdate({Key? key}) : super(key: key);

  @override
  State<ShopDetailsUpdate> createState() => _ShopDetailsUpdateState();
}

class _ShopDetailsUpdateState extends State<ShopDetailsUpdate> {
  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    controller.getShopDetailsNetworkApi();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        await Get.to(()=> const DashboardScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white,size: 18.r),
          backgroundColor: TColor.themecolor,
          title: Text(
            "Shop Details",
            style: bodyText1Style.copyWith(fontSize: 19.sp, color: Colors.white),
          ),
        ),
        body: FadeInUp(
                delay: const Duration(milliseconds: 350),
                child: Container(
                  margin: const EdgeInsets.only(right: 0, top: 20),
                  child: SingleChildScrollView(
                    child: GetBuilder<LoginController>(
                     builder: (controller) {
                       var allData = controller.shopDetails.value.data;
                       controller.shopName.text = allData.shopName.toString()??"";
                       controller.shopImage.value = allData.shopPhoto.toString()??"";
                       controller.description.text = allData.description.toString()??"";
                       controller.serviceCapacity.text = allData.byckServiceCapicity.toString()??"";
                       controller.normalCc.value = allData.normalCcByck.toString() == "Yes" ? 1 : 0;
                       controller.highPickup.value = allData.heighPickup.toString() == "Yes" ? 1 : 0;
                       controller.roadService.value = int.parse(allData.isOnRoadService.toString()??"");
                       controller.startTime.text = allData.storeTime.toString().substring(0,7)??"";
                       Rx<String?> gender = (allData.selectVehicle!=""&&allData.selectVehicle!=null?allData.selectVehicle.toString().capitalize:"Select Vehicle").obs;
                       controller.endTime.text = allData.storeTime.toString().substring(allData.storeTime!.length-7)??"";
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: controller.formKey1,
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
                              // DropdownButtonFormField(
                              //   itemHeight: 50.r,
                              //   isExpanded: true,
                              //   items: ["Select Vehicle", "Two wheeler", "Four Wheeler", "both two wheeler and four wheeler", "Other"].map((String value) {
                              //     return DropdownMenuItem<String>(
                              //       value: value,
                              //       child: Text(value,style: TextStyle(fontSize: 14.r),),
                              //     );
                              //   }).toList(),
                              //   value: gender.value,// Set the default value here
                              //   onChanged: (String? newValue) {
                              //     gender.value = newValue ?? "Select Vehicle";
                              //     print("gender = ${gender.value}");
                              //   },
                              //   decoration: InputDecoration(
                              //     labelText: "Select Vehicle",
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
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please Select Vehicle';
                              //     }
                              //     return null;
                              //   },
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
                                  gender.value = newValue ?? "Select Vehicle";

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
                              // SizedBox(height: 10.0.h),
                              // EditTextWidget(
                              //   hint: 'Vehicle Name',
                              //   label: const Text('Vehicle Name'),
                              //   controller: controller.VehicleName,
                              //   validator: (value) {
                              //     if (value.toString().isEmpty) {
                              //       return "Please enter Vehicle name";
                              //     }
                              //     return null;
                              //   },
                              // ),
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
                          /*  SizedBox(height: 10.0.h),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Normal CC      :',
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeDefault)),
                                Obx(() => Radio(
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
                                Obx(() => Radio(
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
                                // SizedBox(width: 5.0.w),
                                Obx(() => Radio(
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
                                Obx(() => Radio(
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
                                Obx(() => Radio(
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
                            Obx(() => controller.shopPath.value.isEmpty
                                  ? InkWell(
                                    onTap: ()=> showAnimation(context),
                                    child: Container(
                                      height: 120.0.h.h,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0.w,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(5.0.r),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+controller.shopImage.value.toString()),
                                              fit: BoxFit.cover)),
                                      child: Obx(
                                            () => controller.isLoading.value
                                            ? CircularProgressIndicator(
                                            color: TColor.grey)
                                            : const SizedBox(

                                        ),
                                    )),
                                  )
                                  : InkWell(
                                    onTap: ()=> showAnimation(context),
                                    child: Container(
                                      height: 120.0.h,
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
                            ),
                            SizedBox(height: 20.0.h),
                            CustomButton(onPress: () async{
                              if (controller.formKey1.currentState!.validate()) {
                                bool status = await controller.updateShopProfile("Details have successfully updated");
                                if(status == true){
                                  Get.to(()=> const DashboardScreen());
                                }
                              }
                            }, title: 'Update Details',)
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAnimation(BuildContext context) {
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
                        AppConstants.BASE_URL+controller.shopImage.value.toString()),
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
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      imageProvider: FileImage(
                          File(controller.shopPath.value)),
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
