// ignore_for_file: deprecated_member_use, avoid_print, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/map_screen.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'service_type_details.dart';

class DashboardDetails extends StatefulWidget {
  const DashboardDetails({super.key});

  @override
  State<DashboardDetails> createState() => _DashboardDetailsState();
}

final LoginController controller = Get.put(LoginController());

class _DashboardDetailsState extends State<DashboardDetails> {
  final RxBool isLightTheme = false.obs;
  var value = "";
  RxInt indexValue = 0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  final DetailsController detailsController = Get.put(DetailsController());
  RxInt activeStep = 0.obs;
  var selectedValue = "".obs;
  RxDouble distanceInMeters = 0.0.obs;

  @override
  void initState() {
    controller.getListItemDataCountNetworkApi();
    detailsController.getCategoryNetworkApi();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMap();
    });
    super.initState();
  }

  Future<void> _initializeMap() async {
    GoogleMapController.init;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async{
        await Get.to(()=> const DashboardScreen());
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            95.0.h,
          ),
          child: Stack(
            children: [
              ClipRRect(
                child: AppBar(
                  elevation: 0,
                  backgroundColor: TColor.themecolor,
                  title: const Text("All Details"),
                  leadingWidth: 30.w,
                    leading: IconButton(onPressed: (){Get.to(()=> const DashboardScreen());},
                      icon: Icon(Icons.arrow_back, size: 22.sp,)),
                  actions: [
                    Container(
                      height: 28.0.h,
                      margin: const EdgeInsets.only(top: 4.0, bottom: 3),
                      alignment: Alignment.centerLeft,
                      child: SearchBarAnimation(
                        buttonColour: TColor.themecolor,
                        searchBoxColour: TColor.themecolor.withOpacity(0.6),
                        cursorColour: Colors.pink,
                        buttonShadowColour: TColor.green,
                        hintTextColour: TColor.white,
                        buttonElevation: 0.0,
                        searchBoxWidth: width * 0.91,
                        isOriginalAnimation: false,
                        hintText: "Search...",
                        enteredTextStyle: robotoText.copyWith(color: TColor.white),
                        searchBoxBorderColour: Colors.transparent,
                        buttonBorderColour: Colors.white,
                        onChanged: (value){
                          value = value;
                          detailsController.searchBookingOrderNetworkApi("", controller.listItemData.value.data[indexValue.value].id.toString(), value);
                        },
                        onEditingComplete: (value){
                          detailsController.searchBookingOrderNetworkApi("", controller.listItemData.value.data[indexValue.value].id.toString(), value);
                        },
                        onFieldSubmitted: (String value){
                          debugPrint('onFieldSubmitted value $value');
                        }, textEditingController: TextEditingController(),
                        trailingWidget: GestureDetector(
                          onTap: (){
                            detailsController.searchBookingOrderNetworkApi("", controller.listItemData.value.data[indexValue.value].id.toString(), value);
                          },
                           child: Icon(Icons.search_outlined, size: 22.sp, color: TColor.white)
                        ),
                        secondaryButtonWidget: Icon(Icons.clear,size: 22.sp,color: TColor.white,), buttonWidget: Icon(Icons.search_outlined,size: 22.sp,color: TColor.white),
                        isSearchBoxOnRightSide: false,
                        textAlignToRight: false,
                        enableKeyboardFocus: true,
                        enableButtonBorder: false,
                        enableBoxBorder: false,
                        enableBoxShadow: false,
                        enableButtonShadow: false,
                      ),
                    ),
                    SizedBox(height: 5.0.w),
                    InkWell(
                      onTap: () => showPopupMenuButton(context),
                      child: Icon(
                        Icons.filter_list,
                        color: TColor.white,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 8.0.w),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(4.0.h),
                    child: Container(
                        color: Colors.white,
                        height: 50.0.h,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: GetBuilder<LoginController>(builder: (controller) {
                          return controller.listItemData.value.data.isNotEmpty
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount:
                                      controller.listItemData.value.data.length,
                                  padding: EdgeInsets.only(left: 8.0.w),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    var listItemData =
                                        controller.listItemData.value.data[index];
                                    var dataCheck =
                                        (controller.selectTtlValue.value) ==
                                            controller
                                                .listItemData.value.data[index].id
                                                .toString();
                                    return GetBuilder<DetailsController>(
                                        builder: (detailsController) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {});
                                          indexValue.value = index;
                                          controller.selectTtlValue.value =
                                              controller.listItemData.value
                                                  .data[indexValue.value].id
                                                  .toString();
                                          detailsController
                                              .getBookDetailsNetworkApi(
                                                  "",
                                                  controller.listItemData.value
                                                      .data[indexValue.value].id
                                                      .toString(),
                                                  "");
                                        },
                                        child: AnimatedContainer(
                                            duration:
                                                const Duration(milliseconds: 300),
                                            margin:
                                                EdgeInsets.only(right: 10.0.w),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0.w,
                                                vertical: 5.0.h),
                                            decoration: BoxDecoration(
                                                color: dataCheck
                                                    ? TColor.themecolor
                                                    : TColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.0.r),
                                                border: Border.all(
                                                    width: 0.5.r,
                                                    color: TColor.themecolor)),
                                            child: Text(
                                              listItemData.title.toString(),
                                              style: robotoRegular.copyWith(
                                                  color: dataCheck
                                                      ? TColor.white
                                                      : TColor.black),
                                            )),
                                      );
                                    });
                                  })
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 5,
                                  padding: EdgeInsets.only(left: 8.0.w),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    return Shimmer.fromColors(
                                      baseColor: TColor.themecolor.withOpacity(0.1),
                                      highlightColor: TColor.themecolor.withAlpha(80),
                                      direction: ShimmerDirection.ltr,
                                      period: const Duration(seconds: 2),
                                      child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: EdgeInsets.only(right: 10.0.w),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40.0.w,
                                              vertical: 5.0.h),
                                          decoration: BoxDecoration(
                                              color: TColor.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0.r),
                                              border: Border.all(
                                                  width: 0.5.r,
                                                  color: TColor.themecolor))),
                                    );
                                  });
                        })),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          color: TColor.themecolor,
          onRefresh: () {
            return Future.delayed(Duration.zero, () {
              controller.getListItemDataCountNetworkApi();
              detailsController.getCategoryNetworkApi();
            });
          },
          child: SingleChildScrollView(
              controller: detailsController.scrollController,
              child: GetBuilder<DetailsController>(builder: (detailsController) {
                return detailsController.serviceModel.value.data.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: detailsController.serviceModel.value.data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = detailsController
                                  .serviceModel.value.data[index];
                              detailsController.bookingId.value =
                                  detailsController.serviceModel.value.data[index].id.toString();
                              lat.value = double.parse(data.latitude.toString());
                              long.value = double.parse(data.longitude.toString());
                              double startLatitude = controller.latitude
                                  .value; // Replace with your starting latitude
                              double startLongitude = controller.longitude
                                  .value; // Replace with your starting longitude
                              double endLatitude =
                                  lat.value; // Replace with your ending latitude
                              double endLongitude = long
                                  .value; // Replace with your ending longitude
                              var bStatus = int.parse(data.bookingStatus.toString()) > 0;
                              var distance = Geolocator.distanceBetween(
                                startLatitude,
                                startLongitude,
                                endLatitude,
                                endLongitude,
                              );
                              distanceInMeters.value =
                                  double.parse(distance.toStringAsFixed(1));
                              launchCaller() async {
                                final url = "tel: ${data.mobileNo}";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                              String booknig_status="";

                              if (detailsController
                                      .serviceModel.value.data.isNotEmpty &&
                                  index <
                                      detailsController
                                          .serviceModel.value.data.length) {
                                return Container(
                                  margin: EdgeInsets.only(top: index == 0 ? 0 : 8.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .disabledColor
                                              .withAlpha(50),
                                          offset: const Offset(
                                            1.0,
                                            1.0,
                                          ),
                                          blurRadius: 2.0,
                                          spreadRadius: 1.0,
                                        ),
                                        const BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5.0.h),
                                      SizedBox(
                                        height: 30.0.h,
                                        width: Get.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Order No       : ",
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeDefault2),
                                                    ),
                                                    SizedBox(width: 6.0.w),
                                                    Text(
                                                      data.bookingNo ?? 'N/A',
                                                      style: robotoRegular
                                                          .copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault,
                                                              color: TColor.black
                                                                  .withAlpha(
                                                                      150)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 110.0.h,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Owner            : ',
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault2),
                                                ),
                                                SizedBox(width: 5.0.w),
                                                Expanded(
                                                    child: Text(
                                                  data.ownerName ?? 'N/A',
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault,
                                                      color: TColor.black
                                                          .withAlpha(150)),
                                                  maxLines: 3,
                                                )),
                                              ],
                                            ),
                                            SizedBox(height: 2.0.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Service Type : ',
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault2),
                                                ),
                                                SizedBox(width: 5.0.w),
                                                Expanded(
                                                    child: Text(
                                                  data.serviceType ?? 'N/A',
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault,
                                                      color: TColor.black
                                                          .withAlpha(150)),
                                                  maxLines: 3,
                                                )),
                                              ],
                                            ),
                                            SizedBox(height: 2.0.h),
                                            Container(
                                                height: 27.0.h,
                                                width: double.infinity,
                                                alignment: Alignment.centerLeft,
                                                child: EasyStepper(
                                                  activeStep: activeStep.value,
                                                  // fitWidth: Get.width * 0.25,
                                                  alignment: Alignment.center,
                                                  // defaultLineColor: Colors.blue.shade200,
                                                  // finishedLineColor: Colors.green,
                                                  activeStepTextColor:
                                                      TColor.black,
                                                  finishedStepTextColor:
                                                      TColor.black,
                                                  internalPadding: 40.w,
                                                  showLoadingAnimation: false,
                                                  stepRadius: 5,
                                                  showStepBorder: false,
                                                  // lineDotRadius: 1.5,
                                                  steps: [
                                                    EasyStep(
                                                      customStep: CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            Colors.blue.shade200,
                                                        child: CircleAvatar(
                                                          radius: 8,
                                                          backgroundColor:
                                                              activeStep.value >=
                                                                      0
                                                                  ? Colors.green
                                                                  : Colors.blue
                                                                      .shade200,
                                                        ),
                                                      ),
                                                      title: 'Waiting',
                                                    ),
                                                    EasyStep(
                                                        customStep: CircleAvatar(
                                                          radius: 8.r,
                                                          backgroundColor: Colors
                                                              .blue.shade200,
                                                          child: CircleAvatar(
                                                            radius: 8.r,
                                                            backgroundColor:
                                                                activeStep.value >=
                                                                        1
                                                                    ? Colors.green
                                                                    : Colors.blue
                                                                        .shade200,
                                                          ),
                                                        ),
                                                        title: 'Order Pack',
                                                        topTitle: false),
                                                    EasyStep(
                                                      customStep: CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            Colors.blue.shade200,
                                                        child: CircleAvatar(
                                                          radius: 8,
                                                          backgroundColor:
                                                              activeStep.value >=
                                                                      2
                                                                  ? Colors.green
                                                                  : Colors.blue
                                                                      .shade200,
                                                        ),
                                                      ),
                                                      title: 'Order Received',
                                                      topTitle: false,
                                                    ),
                                                    EasyStep(
                                                      customStep: CircleAvatar(
                                                        radius: 8,
                                                        backgroundColor:
                                                            Colors.blue.shade200,
                                                        child: CircleAvatar(
                                                          radius: 8,
                                                          backgroundColor:
                                                              activeStep.value >=
                                                                      3
                                                                  ? Colors.green
                                                                  : Colors.blue
                                                                      .shade200,
                                                        ),
                                                      ),
                                                      title: 'Delivered',
                                                      topTitle: false,
                                                    ),
                                                  ],
                                                  onStepReached: (index) {
                                                    activeStep.value = index;
                                                  },
                                                )),
                                            SizedBox(height: 10.0.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.lat.value =
                                                        double.parse(data.latitude
                                                            .toString());
                                                    controller.long.value =
                                                        double.parse(data
                                                            .longitude
                                                            .toString());
                                                    if (controller.lat.value !=
                                                            0.0 ||
                                                        controller.long.value !=
                                                            0.0) {
                                                      Get.to(() =>
                                                          const MapScreen());
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: const AssetImage(
                                                            "assets/images/send.png"),
                                                        height: 17.h,
                                                        color: Colors.blue,
                                                      ),
                                                      SizedBox(width: 5.0.h),
                                                      Text(
                                                        "Navigate",
                                                        style:
                                                            robotoMedium.copyWith(
                                                                color: TColor
                                                                    .black
                                                                    .withAlpha(
                                                                        180)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 13.w),
                                                InkWell(
                                                  onTap: () => infoBottomSheet(
                                                      context, index),
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: const AssetImage(
                                                            "assets/images/info.png"),
                                                        height: 18.h,
                                                        color: Colors.greenAccent,
                                                      ),
                                                      SizedBox(width: 5.0.h),
                                                      Text(
                                                        "Info",
                                                        style:
                                                            robotoMedium.copyWith(
                                                                color: TColor
                                                                    .black
                                                                    .withAlpha(
                                                                        180)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 13.w),
                                             InkWell(
                                                  onTap: () {
                                                    logoutAlertBox(context,data.id.toString());

                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: const AssetImage(
                                                            "assets/images/reject1.png"),
                                                        height: 18.h,
                                                        color: Colors.red,
                                                      ),
                                                      // SizedBox(width: 2.0.h),
                                                      Text(
                                                        " Reject",
                                                        style:
                                                            robotoMedium.copyWith(
                                                                color: TColor
                                                                    .black
                                                                    .withAlpha(
                                                                        180)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 13.w),
                                                InkWell(
                                                  onTap: launchCaller,
                                                  child: Row(
                                                    children: [
                                                      Image(
                                                        image: const AssetImage(
                                                            "assets/images/call.png"),
                                                        height: 18.h,
                                                        color: Colors.greenAccent,
                                                      ),
                                                      SizedBox(width: 5.0.h),
                                                      Text(
                                                        "Call",
                                                        style:
                                                            robotoMedium.copyWith(
                                                            color: TColor
                                                                    .black
                                                                    .withAlpha(
                                                                        180)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 13.w)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8.0.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          distanceInMeters.value < 100
                                              ? bStatus
                                                  ? Container(
                                                      height: 30.0.h,
                                                      width: Get.width * 0.25,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green.shade200,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0.r),
                                                      ),
                                                      child: Center(
                                                        child: Text("Reached",
                                                            style: robotoRegular
                                                                .copyWith(
                                                                    color: TColor
                                                                        .white)),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        detailsController.reachBtnNetworkApi(data.id.toString(), "1");
                                                        detailsController.getBookDetailsNetworkApi("", controller.listItemData
                                                                    .value
                                                                    .data[
                                                                        indexValue
                                                                            .value]
                                                                    .id
                                                                    .toString(),
                                                                "");
                                                      },
                                                      child: Container(
                                                        height: 30.0.h,
                                                        width: Get.width * 0.25,
                                                        decoration: BoxDecoration(
                                                          color: TColor.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0.r),
                                                        ),
                                                        child: Center(
                                                          child: Text("Reach",
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                      color: TColor
                                                                          .white)),
                                                        ),
                                                      ),
                                                    )
                                              : bStatus
                                                  ? Container(
                                                      height: 30.0.h,
                                                      width: Get.width * 0.25,
                                                      decoration: BoxDecoration(
                                                        color: TColor.green,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0.r),
                                                      ),
                                                      child: Center(
                                                        child: Text("Reached",
                                                            style: robotoRegular
                                                                .copyWith(
                                                                    color: TColor
                                                                        .white)),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                          bStatus
                                              ? InkWell(
                                                  onTap: () async {
                                                    print("booking id : ${data.id.toString()}");
                                                    bool status = await detailsController.getBookingDetailsNetworkApi(data.id.toString());
                                                    if (status == true) {
                                                      Get.to(() => const ServiceTypeDetails());
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 30.0.h,
                                                    width: 130.w,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 20.0.w),
                                                    decoration: BoxDecoration(
                                                      color: TColor.themecolor
                                                          .withAlpha(200),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0.r),
                                                    ),
                                                    child: Center(
                                                      child: Text("View Details",
                                                          style: robotoRegular
                                                              .copyWith(
                                                                  color: TColor
                                                                      .white,fontSize: 14.sp)),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 30.0.h,
                                                  width: Get.width * 0.35,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0.w),
                                                  decoration: BoxDecoration(
                                                    color: TColor.grey
                                                        .withAlpha(160)
                                                        .withAlpha(200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0.r),
                                                  ),
                                                  child: Center(
                                                    child: Text("View Details",
                                                        style: robotoRegular
                                                            .copyWith(
                                                                color: TColor
                                                                    .white)),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0.h),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          SizedBox(height: 5.0.w),
                          Obx(
                            () => detailsController.isLoadingPage.value
                                ? Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SpinKitFadingCircle(
                                          color: TColor.themecolor,
                                          size: 35.0,
                                        ),
                                        SizedBox(width: 8.0.w),
                                        Text("Loading...",style: robotoText.copyWith(fontSize: Dimensions.fontSizeLarge,color: TColor.themecolor),)
                                      ],
                                    ),
                                  )
                                : const Center(),
                          )
                        ],
                      )
                    : Obx(
                        () => detailsController.simmerValue.value
                            ? ListView.builder(
                                itemCount: 10,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10.0,
                                        left: 10,
                                        right: 10,
                                        top: index == 0 ? 5.0 : 0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .disabledColor
                                            .withAlpha(50),
                                        offset: const Offset(
                                          1.0,
                                          1.0,
                                        ),
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0,
                                      ),
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      )
                                    ], borderRadius: BorderRadius.circular(5.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5.0.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                  width: Get.width * 0.30,
                                                  child: Shimmer.fromColors(
                                                    baseColor: TColor.themecolor.withOpacity(0.1),
                                                    highlightColor: TColor.themecolor.withAlpha(80),
                                                    direction: ShimmerDirection.ltr,
                                                    period: const Duration(seconds: 2),
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                2.0.r),
                                                        color: Colors.grey[200],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8.0.h),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: Get.width * 0.35,
                                                  child: Shimmer.fromColors(
                                                    baseColor: TColor.themecolor.withOpacity(0.1),
                                                    highlightColor: TColor.themecolor.withAlpha(80),
                                                    direction: ShimmerDirection.ltr,
                                                    period: const Duration(seconds: 2),
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                2.0.r),
                                                        color: Colors.grey[200],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: 25.h,
                                              width: Get.width * 0.20,
                                              child: Shimmer.fromColors(
                                                baseColor: TColor.themecolor.withOpacity(0.1),
                                                highlightColor: TColor.themecolor.withAlpha(80),
                                                direction: ShimmerDirection.ltr,
                                                period: const Duration(seconds: 2),
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0.r),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0.h),
                                        SizedBox(
                                          height: 10.h,
                                          width: Get.width * 0.50,
                                          child: Shimmer.fromColors(
                                            baseColor: TColor.themecolor.withOpacity(0.1),
                                            highlightColor: TColor.themecolor.withAlpha(80),
                                            direction: ShimmerDirection.ltr,
                                            period: const Duration(seconds: 2),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.0.r),
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        SizedBox(
                                          height: 10.h,
                                          width: Get.width * 0.60,
                                          child: Shimmer.fromColors(
                                            baseColor: TColor.themecolor.withOpacity(0.1),
                                            highlightColor: TColor.themecolor.withAlpha(80),
                                            direction: ShimmerDirection.ltr,
                                            period: const Duration(seconds: 2),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.0.r),
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        SizedBox(
                                          height: 10.h,
                                          width: Get.width * 0.60,
                                          child: Shimmer.fromColors(
                                            baseColor: TColor.themecolor.withOpacity(0.1),
                                            highlightColor: TColor.themecolor.withAlpha(80),
                                            direction: ShimmerDirection.ltr,
                                            period: const Duration(seconds: 2),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2.0.r),
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 15.h,
                                                child: Shimmer.fromColors(
                                                  baseColor: TColor.themecolor.withOpacity(0.1),
                                                  highlightColor: TColor.themecolor.withAlpha(80),
                                                  direction: ShimmerDirection.ltr,
                                                  period: const Duration(seconds: 2),
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0.r)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.0.h),
                                            Expanded(
                                              child: SizedBox(
                                                height: 15.h,
                                                child: Shimmer.fromColors(
                                                  baseColor: TColor.themecolor.withOpacity(0.1),
                                                  highlightColor: TColor.themecolor.withAlpha(80),
                                                  direction: ShimmerDirection.ltr,
                                                  period: const Duration(seconds: 2),
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0.r)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.0.h),
                                            Expanded(
                                              child: SizedBox(
                                                height: 15.h,
                                                child: Shimmer.fromColors(
                                                  baseColor: TColor.themecolor.withOpacity(0.1),
                                                  highlightColor: TColor.themecolor.withAlpha(80),
                                                  direction: ShimmerDirection.ltr,
                                                  period: const Duration(seconds: 2),
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0.r)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.0.h),
                                            Expanded(
                                              child: SizedBox(
                                                height: 15.h,
                                                child: Shimmer.fromColors(
                                                  baseColor: TColor.themecolor.withOpacity(0.1),
                                                  highlightColor: TColor.themecolor.withAlpha(80),
                                                  direction: ShimmerDirection.ltr,
                                                  period: const Duration(seconds: 2),
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0.r)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0.h),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20.h,
                                              width: Get.width * 0.25,
                                              child: Shimmer.fromColors(
                                                baseColor: TColor.themecolor.withOpacity(0.1),
                                                highlightColor: TColor.themecolor.withAlpha(80),
                                                direction: ShimmerDirection.ltr,
                                                period: const Duration(seconds: 2),
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0.r)),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              height: 20.h,
                                              width: Get.width * 0.25,
                                              child: Shimmer.fromColors(
                                                baseColor: TColor.themecolor.withOpacity(0.1),
                                                highlightColor: TColor.themecolor.withAlpha(80),
                                                direction: ShimmerDirection.ltr,
                                                period: const Duration(seconds: 2),
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0.r)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 250.0.h),
                                child: Text(
                                  "No data found!!",
                                  style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge),
                                )),
                      );
              })),
        ),
      ),
    );
  }
  void logoutAlertBox(BuildContext context, String data) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => Dialog(
        alignment: Alignment.center,
        insetPadding: EdgeInsets.symmetric(horizontal: 25.0.w,),
        backgroundColor: TColor.lightGrey.withAlpha(150),
        child: WillPopScope(
          onWillPop:Future.value,
          child: Container(
            height: 170.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20..w, vertical: 10.0.h),
            width: double.infinity,
            decoration: BoxDecoration(
                color: TColor.lightGrey,
                borderRadius: BorderRadius.circular(5.0.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Logout",
                  style: robotoText.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                    height: 20.h
                ),
                Text(
                  "Are you sure, do you want to logout?\n"
                      "please press Yes otherwise No !!",
                  style: robotoText.copyWith(fontSize: 15.sp, height: 1.3),
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Get.back();
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5))),
                      color: Colors.green.shade500,
                      child: Text("No",
                          style: robotoRegular.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                          )),
                    ),
                    const Spacer(),
                    MaterialButton(
                      onPressed: () {
                        detailsController.getRejectedNetworkApi(data,"0");
                        Get.back();
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      color: Colors.red.shade400,
                      child: Text("Reject",
                          style: robotoRegular.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Function to show the PopupMenuButton
  void showPopupMenuButton(BuildContext context) {
    if (detailsController.getCategoryData.value.data.isNotEmpty) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            Get.width * 0.85, 40, 0, 0), // Adjust the position as needed
        items: detailsController.getCategoryData.value.data.map((value) {
          return PopupMenuItem(
            value: value,
            child: Text(value.title.toString()),
          );
        }).toList(),
      ).then((value) {
        if (value != null) {
          setState(() {});
          selectedValue.value = value.id.toString();
          detailsController.getBookDetailsNetworkApi(
              selectedValue.value,
              controller.listItemData.value.data[indexValue.value].id
                  .toString(),
              "");
        }
      });
    } else {
      print('No data found!');
    }
  }

  infoBottomSheet(BuildContext context, int index) {
    var data = detailsController.serviceModel.value.data[index];
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: 220.0.h,
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User Booking Details",
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: TColor.themecolor),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        size: 23.sp,
                        color: TColor.red,
                      )),
                ],
              ),
              Container(
                height: 1.0.h,
                color: TColor.lightGrey,
              ),
              SizedBox(height: 8.0.h),
              // CustomTitleSubtitle(title: "Order No", subTitle: data.bookingNo??"NA"),
              // SizedBox(height: 5.0.h),
              CustomTitleSubtitle(
                  title: "User Name", subTitle: data.username ?? "NA"),
              SizedBox(height: 5.0.h),
              CustomTitleSubtitle(
                  title: "Service Type", subTitle: data.serviceType ?? "NA"),
              SizedBox(height: 5.0.h),
              CustomTitleSubtitle(
                title: "Service Date",
                subTitle: data.serviceDate ?? "NA",
              ),
              SizedBox(height: 5.0.h),
              CustomTitleSubtitle(
                title: "Brand",
                subTitle: data.brandName ?? "NA",
              ),
              SizedBox(height: 5.0.h),
              CustomTitleSubtitle(
                title: "Slot",
                subTitle: data.slotId ?? "NA",
              ),
              SizedBox(height: 5.0.h),
              CustomTitleSubtitle(
                title: "Bike CC",
                subTitle: data.bikeCc ?? "NA",
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomTitleSubtitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomTitleSubtitle(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width * 0.30.w,
          child: Text(
            title,
            style: robotoText.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: TColor.black.withAlpha(180)),
          ),
        ),
        Expanded(
            child: Text(
          subTitle,
          style: robotoText.copyWith(
              fontSize: Dimensions.fontSizeLarge, color: TColor.grey),
        )),
      ],
    );
  }
}
