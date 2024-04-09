// ignore_for_file: deprecated_member_use, avoid_print, file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:image_picker/image_picker.dart';

class PickImages extends StatefulWidget {
  final String bookingId;
  final String status;
  const PickImages({Key? key, required this.bookingId, required this.status})
      : super(key: key);

  @override
  State<PickImages> createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<DetailsController>(builder: (controller) {
        return controller.getBookingDetails.value.data.pickedupImage.isEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(height: 20.0.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print('love');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Please upload the image"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: const Text("Camera"),
                                      onPressed: () {
                                        controller.pickPhoto1(
                                            context, ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    MaterialButton(
                                      child: const Text("Gallery"),
                                      onPressed: () {
                                        controller.pickPhoto1(
                                            context, ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Card(
                                    elevation: 4,
                                    shadowColor: Colors.blue,
                                    child: Container(
                                      height: 120.h,
                                      width: 120.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green.shade400,
                                            width: 2),
                                      ),
                                      child: Obx(() => controller.pickImage1.value == null
                                            ? Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.filter_1_rounded,
                                                      color: Colors.grey,
                                                      size: 30.sp,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Image.file(
                                                controller.pickImage1.value!,
                                                fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0.w,
                                      top: 0.h,
                                      child: IconButton(
                                        onPressed: () {
                                          controller.pickImage1.value = null;
                                        },
                                        icon: Icon(
                                          Icons.highlight_remove,
                                          size: 25.sp,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Please upload the image"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: const Text("Camera"),
                                      onPressed: () {
                                        controller.pickPhoto2(
                                            context, ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    MaterialButton(
                                      child: const Text("Gallery"),
                                      onPressed: () {
                                        controller.pickPhoto2(
                                            context, ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Card(
                                    elevation: 4,
                                    shadowColor: Colors.blue,
                                    child: Container(
                                      height: 120.h,
                                      width: 120.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green.shade400,
                                            width: 2),
                                      ),
                                      child: Obx(() => controller.pickImage2.value == null
                                            ? Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.filter_2_rounded,
                                                      color: Colors.grey,
                                                      size: 30.sp,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Image.file(
                                                controller.pickImage2.value!,
                                                fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0.w,
                                      top: 0.h,
                                      child: IconButton(
                                        onPressed: () {
                                          controller.pickImage2.value = null;
                                        },
                                        icon: Icon(
                                          Icons.highlight_remove,
                                          size: 25.sp,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Please upload the image"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: const Text("Camera"),
                                      onPressed: () {
                                        controller.pickPhoto3(
                                            context, ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    MaterialButton(
                                      child: const Text("Gallery"),
                                      onPressed: () {
                                        controller.pickPhoto3(
                                            context, ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Card(
                                    elevation: 4,
                                    shadowColor: Colors.blue,
                                    child: Container(
                                      height: 120.h,
                                      width: 120.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green.shade400,
                                            width: 2),
                                      ),
                                      child: Obx(() => controller.pickImage3.value == null
                                            ? Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.filter_3_rounded,
                                                      color: Colors.grey,
                                                      size: 25.sp,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Image.file(
                                                controller.pickImage3.value!,
                                                fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0.w,
                                      top: 0.h,
                                      child: IconButton(
                                        onPressed: () {
                                          controller.pickImage3.value = null;
                                        },
                                        icon: Icon(
                                          Icons.highlight_remove,
                                          size: 25.sp,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Please upload the image"),
                                  actions: <Widget>[
                                    MaterialButton(
                                      child: const Text("Camera"),
                                      onPressed: () {
                                        controller.pickPhoto4(
                                            context, ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    MaterialButton(
                                      child: const Text("Gallery"),
                                      onPressed: () {
                                        controller.pickPhoto4(
                                            context, ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Card(
                                    elevation: 4,
                                    shadowColor: Colors.blue,
                                    child: Container(
                                      height: 120.h,
                                      width: 120.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green.shade400,
                                            width: 2),
                                      ),
                                      child: Obx(() => controller.pickImage4.value == null
                                            ? Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.filter_4_rounded,
                                                      color: Colors.grey,
                                                      size: 25.sp,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Image.file(
                                                controller.pickImage4.value!,
                                                fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0.w,
                                      top: 0.h,
                                      child: IconButton(
                                        onPressed: () {
                                          controller.pickImage4.value = null;
                                        },
                                        icon: Icon(
                                          Icons.highlight_remove,
                                          size: 25.sp,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async{
                        if (controller.pImage1.value.isNotEmpty ||
                            controller.pImage2.value.isNotEmpty ||
                            controller.pImage3.value.isNotEmpty ||
                            controller.pImage4.value.isNotEmpty) {
                            bool status = await controller.bookingStatusNetworkApi(widget.bookingId, widget.status);
                            if (status == true) {
                              controller.pImage1.value = "";
                              controller.pImage2.value = "";
                              controller.pImage3.value = "";
                              controller.pImage4.value = "";
                              controller.getBookingDetailsNetworkApi(widget.bookingId);
                            }
                        } else {
                          CustomAnimation().showCustomToast(
                              "Please choose all images",
                              isError: true);
                        }
                      },
                      child: Container(
                        height: 40.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                            child: Text(
                          "UPLOAD",
                          style: robotoMedium.copyWith(
                              fontSize: 18.sp, color: Colors.black87),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0.h),
                ],
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                itemCount: controller.getBookingDetails.value.data.pickedupImage.length >
                        4
                    ? 4
                    : controller
                        .getBookingDetails.value.data.pickedupImage.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0 / 1.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  var data = controller
                      .getBookingDetails.value.data.pickedupImage[index];
                  return GetBuilder<DetailsController>(builder: (controller) {
                    return controller.getBookingDetails.value.data.pickedupImage
                            .isNotEmpty
                        ? Card(
                            elevation: 4,
                            shadowColor: Colors.blue,
                            child: Container(
                              height: 120.h,
                              width: 120.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green.shade400, width: 2),
                              ),
                              child: data.image.toString().isNotEmpty
                                  ? Image.network(
                                      AppConstants.BASE_URL +
                                          data.image.toString(),
                                      fit: BoxFit.fill)
                                  : Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircularProgressIndicator(
                                        color: TColor.grey,
                                      )),
                            ),
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5.0),
                            child: CircularProgressIndicator(
                              color: TColor.grey,
                            ));
                  });
                });
      }),
    );
  }
}

// Delivered Image screen widget
class DeliveredImage extends StatefulWidget {
  final String bookingId;
  final String status;
  const DeliveredImage(
      {Key? key, required this.bookingId, required this.status})
      : super(key: key);

  @override
  State<DeliveredImage> createState() => _DeliveredImageState();
}

class _DeliveredImageState extends State<DeliveredImage> {
  DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(builder: (controller) {
      return controller.getBookingDetails.value.data.deliveredImage.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 20.0.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print('love');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Please upload the image"),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: const Text("Camera"),
                                    onPressed: () {
                                      controller.deliveredPhoto1(
                                          context, ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Text("Gallery"),
                                    onPressed: () {
                                      controller.deliveredPhoto1(
                                          context, ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Card(
                                  elevation: 4,
                                  shadowColor: Colors.blue,
                                  child: Container(
                                    height: 120.h,
                                    width: 120.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2),
                                    ),
                                    child: Obx(() => controller.deliveredImage1.value == null
                                              ? Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.filter_1_rounded,
                                                        color: Colors.grey,
                                                        size: 30.sp,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Image.file(
                                                  File(controller
                                                      .dImage1.value
                                                      .toString()),
                                                  fit: BoxFit.fitWidth),
                                        ),
                                  ),
                                ),
                                Positioned(
                                    right: 0.w,
                                    top: 0.h,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.deliveredImage1.value = null;
                                      },
                                      icon: Icon(
                                        Icons.highlight_remove,
                                        size: 25.sp,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Please upload the image"),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: const Text("Camera"),
                                    onPressed: () {
                                      controller.deliveredPhoto2(
                                          context, ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Text("Gallery"),
                                    onPressed: () {
                                      controller.deliveredPhoto2(
                                          context, ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Card(
                                  elevation: 4,
                                  shadowColor: Colors.blue,
                                  child: Container(
                                    height: 120.h,
                                    width: 120.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2),
                                    ),
                                    child: Obx(() => controller.deliveredImage2.value == null
                                              ? Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.filter_2_rounded,
                                                        color: Colors.grey,
                                                        size: 30.sp,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Image.file(
                                                  File(controller
                                                      .dImage2.value
                                                      .toString()),
                                                  fit: BoxFit.fitWidth),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0.w,
                                    top: 0.h,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.deliveredImage2.value = null;
                                      },
                                      icon: Icon(
                                        Icons.highlight_remove,
                                        size: 25.sp,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print('love');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Please upload the image"),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: const Text("Camera"),
                                    onPressed: () {
                                      controller.deliveredPhoto3(
                                          context, ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Text("Gallery"),
                                    onPressed: () {
                                      controller.deliveredPhoto3(
                                          context, ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Card(
                                  elevation: 4,
                                  shadowColor: Colors.blue,
                                  child: Container(
                                    height: 120.h,
                                    width: 120.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2),
                                    ),
                                    child: Obx(() => controller.deliveredImage3.value == null
                                              ? Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.filter_3_rounded,
                                                        color: Colors.grey,
                                                        size: 25.sp,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Image.file(
                                                  File(controller
                                                      .dImage3.value
                                                      .toString()),
                                                  fit: BoxFit.fitWidth),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0.w,
                                    top: 0.h,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.deliveredImage3.value = null;
                                      },
                                      icon: Icon(
                                        Icons.highlight_remove,
                                        size: 25.sp,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          print('love');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Please upload the image"),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: const Text("Camera"),
                                    onPressed: () {
                                      controller.deliveredPhoto4(
                                          context, ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  MaterialButton(
                                    child: const Text("Gallery"),
                                    onPressed: () {
                                      controller.deliveredPhoto4(
                                          context, ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Card(
                                  elevation: 4,
                                  shadowColor: Colors.blue,
                                  child: Container(
                                    height: 120.h,
                                    width: 120.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2),
                                    ),
                                    child: Obx(() => controller.deliveredImage4.value == null
                                              ? Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.filter_4_rounded,
                                                        color: Colors.grey,
                                                        size: 25.sp,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Image.file(
                                                  File(controller
                                                      .dImage4.value
                                                      .toString()),
                                                  fit: BoxFit.fitWidth),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0.w,
                                    top: 0.h,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.deliveredImage4.value = null;
                                      },
                                      icon: Icon(
                                        Icons.highlight_remove,
                                        size: 25.sp,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: InkWell(
                    onTap: ()async {
                      if (controller.dImage1.value.isNotEmpty ||
                          controller.dImage2.value.isNotEmpty ||
                          controller.dImage3.value.isNotEmpty ||
                          controller.dImage4.value.isNotEmpty) {
                          bool status = await controller.bookingStatusNetworkApi(widget.bookingId, widget.status);
                          if (status == true) {
                            controller.getBookingDetailsNetworkApi(widget.bookingId);
                            controller.dImage1.value = "";
                            controller.dImage2.value = "";
                            controller.dImage3.value = "";
                            controller.dImage4.value = "";
                          }
                      } else {
                        CustomAnimation().showCustomToast("Please choose all images", isError: true);
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                          child: Text(
                        "UPLOAD",
                        style: robotoMedium.copyWith(
                            fontSize: 18.sp, color: Colors.black87),
                      )),
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
              ],
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              itemCount: controller
                          .getBookingDetails.value.data.deliveredImage.length >
                      4
                  ? 4
                  : controller
                      .getBookingDetails.value.data.deliveredImage.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0 / 1.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0),
              itemBuilder: (context, index) {
                var data = controller
                    .getBookingDetails.value.data.deliveredImage[index];
                return GetBuilder<DetailsController>(builder: (controller) {
                  return controller.getBookingDetails.value.data.deliveredImage
                          .isNotEmpty
                      ? Card(
                          elevation: 4,
                          shadowColor: Colors.blue,
                          child: Container(
                            height: 120.h,
                            width: 120.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.green.shade400, width: 2),
                            ),
                            child: data.image.toString().isNotEmpty
                                ? Image.network(
                                    AppConstants.BASE_URL +
                                        data.image.toString(),
                                    fit: BoxFit.fill)
                                : Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircularProgressIndicator(
                                      color: TColor.grey,
                                    )),
                          ),
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5.0),
                          child: CircularProgressIndicator(
                            color: TColor.grey,
                          ));
                });
              });
    });
  }
}
