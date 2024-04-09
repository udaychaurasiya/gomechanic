import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:shimmer/shimmer.dart';
import 'service_type_details.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  State<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  LoginController controller = Get.put(LoginController());
  final DetailsController detailsController = Get.put(DetailsController());

  _AllNotificationsState() {
    controller.getNotificationNetworkApi();
  }

  @override
  void initState() {
    controller.getNotificationNetworkApi();
    controller.scrollNotificationsController = ScrollController();
    controller.addItems();
    super.initState();
  }

  @override
  void dispose() {
    controller.scrollNotificationsController.dispose();
    super.dispose();
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
          leading: IconButton(
              onPressed: () {
                Get.to(() => const DashboardScreen());
              },
              icon: Icon(
                Icons.arrow_back,
                size: 22.sp,
              )),
          backgroundColor: TColor.themecolor,
          title: const Text('Notifications'),
        ),
        body: GetBuilder<LoginController>(builder: (controller) {
          return SingleChildScrollView(
              controller: controller.scrollNotificationsController,
              child: Column(
                children: [
                  SizedBox(height: 5.0.h),
                  controller.allNotification.value.data.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              controller.allNotification.value.data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = controller.allNotification.value.data[index];
                            return InkWell(
                              onTap: () async {
                                bool status = await detailsController
                                    .getBookingDetailsNetworkApi(
                                        data.typeId.toString());
                                if (status == true) {
                                  Get.to(() => const ServiceTypeDetails());
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0.w, vertical: 4.0.h),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 23.0.sp,
                                          backgroundColor:
                                              TColor.lightGrey.withAlpha(150),
                                          child: Icon(
                                            Icons.notifications,
                                            size: 23.sp,
                                            color: Colors.black.withAlpha(180),
                                          ),
                                        ),
                                        SizedBox(width: 8.0.w),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              data.mesage.toString(),
                                              style: robotoMedium.copyWith(
                                                  color: TColor.black,
                                                  fontSize: Dimensions
                                                      .fontSizeDefault),
                                            ),
                                            SizedBox(
                                              height: 3.0.h,
                                            ),
                                            Text(
                                              data.addDate
                                                  .toString()
                                                  .substring(0, 11),
                                              style: robotoRegular.copyWith(
                                                  color: TColor.greyText,
                                                  fontSize: Dimensions
                                                      .fontSizeDefault),
                                            ),
                                          ],
                                        )),
                                        SizedBox(width: 3.0.w),
                                        Text(
                                          data.addDate.toString().substring(11),
                                          style: TextStyle(color: TColor.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                      color: TColor.themecolor.withAlpha(100)),
                                ],
                              ),
                            );
                          })
                      : Obx(() => controller.simmer.value == true
                          ? ListView.builder(
                              itemCount: 12,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.w, vertical: 4.0.h),
                                        child: Row(
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: TColor.themecolor
                                                  .withOpacity(0.1),
                                              highlightColor: TColor.themecolor
                                                  .withAlpha(80),
                                              direction: ShimmerDirection.ltr,
                                              period:
                                                  const Duration(seconds: 2),
                                              child: CircleAvatar(
                                                radius: 23.0.sp,
                                                backgroundColor: TColor
                                                    .lightGrey
                                                    .withAlpha(150),
                                              ),
                                            ),
                                            SizedBox(width: 8.0.w),
                                            SizedBox(
                                              width: Get.width * 0.64,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Shimmer.fromColors(
                                                      baseColor: TColor
                                                          .themecolor
                                                          .withOpacity(0.1),
                                                      highlightColor: TColor
                                                          .themecolor
                                                          .withAlpha(80),
                                                      direction:
                                                          ShimmerDirection.ltr,
                                                      period: const Duration(
                                                          seconds: 2),
                                                      child: Container(
                                                        height: 12.0.h,
                                                        width: Get.width * 0.55,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0.r)),
                                                      )),
                                                  SizedBox(
                                                    height: 3.0.h,
                                                  ),
                                                  Shimmer.fromColors(
                                                      baseColor: TColor
                                                          .themecolor
                                                          .withOpacity(0.1),
                                                      highlightColor: TColor
                                                          .themecolor
                                                          .withAlpha(80),
                                                      direction:
                                                          ShimmerDirection.ltr,
                                                      period: const Duration(
                                                          seconds: 2),
                                                      child: Container(
                                                        height: 12.0.h,
                                                        width: Get.width * 0.45,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0.r)),
                                                      )),
                                                  SizedBox(
                                                    height: 3.0.h,
                                                  ),
                                                  Shimmer.fromColors(
                                                      baseColor: TColor
                                                          .themecolor
                                                          .withOpacity(0.1),
                                                      highlightColor: TColor
                                                          .themecolor
                                                          .withAlpha(80),
                                                      direction:
                                                          ShimmerDirection.ltr,
                                                      period: const Duration(
                                                          seconds: 2),
                                                      child: Container(
                                                        height: 12.0.h,
                                                        width: Get.width * 0.22,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0.r)),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 3.0.w),
                                            Shimmer.fromColors(
                                                baseColor: TColor.themecolor
                                                    .withOpacity(0.1),
                                                highlightColor: TColor
                                                    .themecolor
                                                    .withAlpha(80),
                                                direction: ShimmerDirection.ltr,
                                                period:
                                                    const Duration(seconds: 2),
                                                child: Container(
                                                  height: 14.0.h,
                                                  width: Get.width * 0.15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0.r)),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                          color:
                                              TColor.themecolor.withAlpha(100)),
                                    ],
                                  ),
                                );
                              })
                          : Container(
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(top: 280.0.h, bottom: 10.0.h),
                              child: Text(
                                "Notification not found!",
                                style: robotoMedium.copyWith(),
                              ),
                            )),
                  Obx(() {
                    return controller.isLoadingPage.value
                        ? Center(
                            child:
                                CircularProgressIndicator(color: TColor.grey),
                          )
                        : const Center();
                  }),
                ],
              ));
        }),
      ),
    );
  }
}
