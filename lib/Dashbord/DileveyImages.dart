// ignore_for_file: avoid_print, deprecated_member_use, file_names

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

// ready deliver Image screen widget
class ReadyDeliverImage extends StatefulWidget {
  final String bookingId;
  final String status;
  const ReadyDeliverImage(
      {Key? key, required this.bookingId, required this.status})
      : super(key: key);

  @override
  State<ReadyDeliverImage> createState() => _ReadyDeliverImageState();
}

class _ReadyDeliverImageState extends State<ReadyDeliverImage> {
  DetailsController controller = Get.put(DetailsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(builder: (controller) {
      return controller.getBookingDetails.value.data.readyDeliverImage.isEmpty
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
                                  controller.deliverPhoto1(
                                      context, ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                child: const Text("Gallery"),
                                onPressed: () {
                                  controller.deliverPhoto1(
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
                                      color: Colors.green.shade400, width: 2),
                                ),
                                child: Obx(() => controller.deliverImage1.value == null
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
                                        File(controller.rImage1.value.toString()),
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 0.w,
                                top: 0.h,
                                child: IconButton(
                                  onPressed: () {
                                    controller.deliverImage1.value = null;
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
                                controller.deliverPhoto2(
                                    context, ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              child: const Text("Gallery"),
                              onPressed: () {
                                controller.deliverPhoto2(
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
                                    color: Colors.green.shade400, width: 2),
                              ),
                              child: Obx(() =>  controller.deliverImage2.value == null
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
                                    File(controller.rImage2.value.toString()),
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0.w,
                              top: 0.h,
                              child: IconButton(
                                onPressed: () {
                                  controller.deliverImage2.value = null;
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
                                  controller.deliverPhoto3(
                                      context, ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                child: const Text("Gallery"),
                                onPressed: () {
                                  controller.deliverPhoto3(
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
                                      color: Colors.green.shade400, width: 2),
                                ),
                                child: Obx(() =>  controller.deliverImage3.value == null
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
                                      File(controller.rImage3.value.toString()),
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 0.w,
                                top: 0.h,
                                child: IconButton(
                                  onPressed: () {
                                    controller.deliverImage3.value = null;
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
                                  controller.deliverPhoto4(
                                      context, ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                child: const Text("Gallery"),
                                onPressed: () {
                                  controller.deliverPhoto4(
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
                                      color: Colors.green.shade400, width: 2),
                                ),
                                child: Obx(() =>  controller.deliverImage4.value == null
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
                                      File(controller.rImage4.value
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
                                    controller.deliverImage4.value = null;
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
            SizedBox(height: 30.h),
            Center(
              child: InkWell(
                onTap: ()async {
                  if (controller.rImage1.value.isNotEmpty ||
                      controller.rImage2.value.isNotEmpty ||
                      controller.rImage3.value.isNotEmpty ||
                      controller.rImage4.value.isNotEmpty) {
                        bool status = await controller.bookingStatusNetworkApi(widget.bookingId, widget.status);
                      if (status == true) {
                        controller.getBookingDetailsNetworkApi(widget.bookingId);
                        controller.rImage1.value = "";
                        controller.rImage2.value = "";
                        controller.rImage3.value = "";
                        controller.rImage4.value = "";
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
                    borderRadius:
                    BorderRadius.circular(30.r), /*border: Border.all()*/
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
          ])
          : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            itemCount: controller
                .getBookingDetails.value.data.readyDeliverImage.length >
                4
                ? 4
                : controller
                .getBookingDetails.value.data.readyDeliverImage.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0 / 1.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0),
            itemBuilder: (context, index) {
              var data = controller
                  .getBookingDetails.value.data.readyDeliverImage[index];
              return GetBuilder<DetailsController>(builder: (controller) {
                return controller.getBookingDetails.value.data.readyDeliverImage
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
                            AppConstants.BASE_URL + data.image.toString(),
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

// Under Service Image widget
class UnderServiceImage extends StatefulWidget {
  final String bookingId;
  final String status;
  const UnderServiceImage(
      {Key? key, required this.bookingId, required this.status})
      : super(key: key);

  @override
  State<UnderServiceImage> createState() => _UnderServiceImageState();
}

class _UnderServiceImageState extends State<UnderServiceImage> {
  DetailsController controller = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<DetailsController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0.h),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                itemCount: controller.getBookingDetails.value.data
                    .underServiceImage.length >
                    4
                    ? 4
                    : controller
                    .getBookingDetails.value.data.underServiceImage.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0 / 1.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  var data = controller
                      .getBookingDetails.value.data.underServiceImage[index];
                  return GetBuilder<DetailsController>(builder: (controller) {
                    return controller.getBookingDetails.value.data
                        .underServiceImage.isNotEmpty
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
                            child: data.image
                                .toString()
                                .isNotEmpty
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
                }),
            SizedBox(
                height: controller.getBookingDetails.value.data
                    .underServiceImage.length >
                    4
                    ? 0
                    : 10.0.h),
            controller.getBookingDetails.value.data.underServiceImage.length > 4
                ? const SizedBox()
                : InkWell(
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
                                controller.servicePhoto(
                                    context, ImageSource.camera);
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              child: const Text("Gallery"),
                              onPressed: () {
                                controller.servicePhoto(context, ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Card(
                        elevation: 4,
                        shadowColor: Colors.blue,
                        child: Container(
                          height: 115.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.green.shade400, width: 2),
                          ),
                          child: Obx(() =>  controller.serviceImage.value == null
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
                                : Image.file(File(controller.uImage1.value.toString()),
                                  fit: BoxFit.fitWidth),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 0.w,
                          top: 0.h,
                          child: IconButton(
                            onPressed: () {
                              controller.serviceImage.value = null;
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
                height: controller.getBookingDetails.value.data
                    .underServiceImage.length >
                    4
                    ? 0
                    : 20.h),
            controller.getBookingDetails.value.data.underServiceImage.length > 4
                ? const SizedBox()
                : Center(
                  child: InkWell(
                  onTap: () async {
                    if (controller.uImage1.value.isNotEmpty) {
                      bool status =
                      await controller.bookingUnderServiceNetworkApi(
                          widget.bookingId, widget.status);
                      if (status == true) {
                        controller.getBookingDetailsNetworkApi(widget.bookingId);
                        controller.uImage1.value = "";
                      }
                    } else {
                      CustomAnimation().showCustomToast(
                          "Please choose images",
                          isError: true);
                    }
                  },
                  child: Container(
                    height: 40.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(
                          30.r),
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
        );
      }),
    );
  }
}
