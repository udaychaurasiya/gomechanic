// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/DileveyImages.dart';
import 'package:gomechanic/Dashbord/PickImages.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/controller/notification_service.dart';
import 'package:gomechanic/helper/custom_dialog.dart';
import 'package:gomechanic/helper/custom_text.dart';
import 'package:gomechanic/utils/all_image.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class ServiceTypeDetails extends StatefulWidget {
  const ServiceTypeDetails({Key? key,}) : super(key: key);

  @override
  State<ServiceTypeDetails> createState() => _ServiceTypeDetailsState();
}

class _ServiceTypeDetailsState extends State<ServiceTypeDetails> {
  NotificationServices notificationServices = NotificationServices();
  final LoginController controller = Get.find();
  final DetailsController detailsController = Get.find();

  @override
  void initState() {
    detailsController.getBookingDetailsNetworkApi(detailsController.getBookingDetails.value.data.id.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  detailsController.saveDataRegistration();
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColor.themecolor,
        title: Text(
          "Service Type Details",
          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<DetailsController>(builder:(detailsController) {
          var data = detailsController.getBookingDetails.value.data;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0.h),
                Container(
                  height: 110.r,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black12.withAlpha(30),
                    borderRadius: BorderRadius.circular(5.0.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 2.0.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomTitleText(text: 'Booking No : '),
                                SizedBox(width: 4.0.w),
                                Expanded(
                                  child: CustomSubTitleText(
                                      text: data.bookingNo.toString()),
                                )
                              ],
                            ),
                            SizedBox(height: 5.r),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomTitleText(text: 'User : '),
                                SizedBox(width: 4.0.w),
                                Expanded(
                                  child:  CustomSubTitleText(
                                      text: data.username.toString()),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomTitleText(text: 'Owner : '),
                                SizedBox(width: 4.0.w),
                                Expanded(
                                  child: CustomSubTitleText(
                                      text: data.ownerName.toString()),
                                )
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomTitleText(text: 'Mobile No : '),
                                SizedBox(width: 4.0.w),
                                Expanded(
                                  child: CustomSubTitleText(
                                      text: data.mobileNo.toString()),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: data.userProfile.toString().isNotEmpty
                              ? InkWell(
                                onTap: () {
                                  showAnimatedDialog(
                                      context,
                                      Center(
                                          child: Container(
                                            width: 320.w,
                                            height: 250.h,
                                            padding: const EdgeInsets.all(
                                                Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.0.w, color: TColor.lightGrey),
                                                borderRadius: BorderRadius.circular(
                                                    Dimensions.RADIUS_DEFAULT),
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
                                                    image: NetworkImage(AppConstants.BASE_URL+data.userProfile.toString()),
                                                    fit: BoxFit.fill)
                                            ),
                                          )),
                                      dismissible: true);
                                },
                                child:Container(
                                  width: 320.w,
                                  height: 250.h,
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0.w, color: TColor.lightGrey),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.RADIUS_DEFAULT),
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
                                          image: NetworkImage(AppConstants.BASE_URL+data.userProfile.toString()),
                                          fit: BoxFit.fill)
                                  ),
                                ),
                              )
                              : Container(
                                width: 320.w,
                                height: 250.h,
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0.w, color: TColor.lightGrey),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_DEFAULT),
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
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(height: 5.0.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTitleText(text: 'Service Type : '),
                    SizedBox(width: 5.0.w),
                    Expanded(
                      child:  CustomSubTitleText(
                          text: data.serviceType.toString()),
                    )
                  ],
                ),
                SizedBox(height: 5.0.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTitleText(text: 'Booking Date : '),
                    SizedBox(width: 5.0.w),
                    Expanded(
                      child:  CustomSubTitleText(
                          text: data.addDate.toString()),
                    )
                  ],
                ),
                SizedBox(height: 5.0.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTitleText(text: 'Service Date : '),
                    SizedBox(width: 5.0.w),
                    Expanded(
                      child: CustomSubTitleText(
                          text: data.serviceDate.toString()),
                    )
                  ],
                ),
                SizedBox(height: 5.0.h),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * 0.44,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTitleText(text: 'Bike CC : '),
                            SizedBox(width: 4.0.w),
                            Expanded(
                              child: CustomSubTitleText(
                                  text: data.bikeCc.toString()
                                      .toString()),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTitleText(text: 'Brand : '),
                            SizedBox(width: 4.0.w),
                            Expanded(
                              child: CustomSubTitleText(
                                  text: data.brandName.toString()
                                      .toString()),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.0.h),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * 0.44,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTitleText(text: 'Status : '),
                            SizedBox(width: 4.0.w),
                            Text(
                              data.status.toString() == "1"
                                  ? 'Pending'
                                  : "Successful",
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: detailsController.status.value == "1"
                                      ? Colors.red.shade400.withAlpha(200)
                                      : Colors.green.shade500.withAlpha(200)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTitleText(text: 'Slot : '),
                            SizedBox(width: 4.0.w),
                            Expanded(
                              child: CustomSubTitleText(
                                  text: data.slotId.toString()
                                      .toString()),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.0.h),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * 0.44,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTitleText(text: 'Vin Number Image'),
                            SizedBox(height: 5.0.h),
                            data.vinNoPic.toString().isNotEmpty
                                ? InkWell(
                              onTap: () {
                                showAnimatedDialog(
                                    context,
                                    Center(
                                      child: Container(
                                        width: 320.w,
                                        height: 250.h,
                                        padding: const EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_LARGE),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.RADIUS_EXTRA_LARGE),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+data.vinNoPic.toString()
                                              ),
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                    ),
                                    dismissible: true);
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 100.0.h,
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    boxShadow: [
                                      BoxShadow(
                                        color: TColor.white,
                                      ),
                                      BoxShadow(
                                        color: TColor.lightGrey,
                                        spreadRadius: -12.0,
                                        blurRadius: 12.0,
                                      )
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            AppConstants.BASE_URL+data.vinNoPic.toString()
                                        ),
                                        fit: BoxFit.cover),
                                  )),
                            )
                                : Center(
                              child: Container(
                                width: 320.w,
                                height: 250.h,
                                padding: const EdgeInsets.all(Dimensions
                                    .PADDING_SIZE_EXTRA_LARGE),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_EXTRA_LARGE),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTitleText(text: 'Owner ID Image'),
                            SizedBox(height: 5.0.h),
                            data.idProve.toString().isNotEmpty
                                ? InkWell(
                              onTap: () {
                                showAnimatedDialog(
                                    context,
                                    Center(
                                      child: Container(
                                          width: 320.0.w,
                                          height: 250.0.h,
                                          padding: const EdgeInsets.all(
                                              Dimensions
                                                  .PADDING_SIZE_EXTRA_LARGE),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_EXTRA_LARGE),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+data.idProve.toString()),
                                                fit: BoxFit.contain),
                                          )),
                                    ),
                                    dismissible: true);
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 100.0.h,
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: TColor.white,
                                      ),
                                      BoxShadow(
                                        color: TColor.lightGrey,
                                        spreadRadius: -12.0,
                                        blurRadius: 12.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            AppConstants.BASE_URL+data.idProve.toString()
                                        ),
                                        fit: BoxFit.cover),
                                  )),
                            )
                                : Container(
                                width: double.infinity,
                                height: 100.0.h,
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: TColor.white,
                                    ),
                                    BoxShadow(
                                      color: TColor.lightGrey,
                                      spreadRadius: -12.0,
                                      blurRadius: 12.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_SMALL),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0.h),
                const CustomTitleText(text: 'Booking Status -'),
                SizedBox(height: 10.0.h),
                Container(
                  decoration: BoxDecoration(
                    color: TColor.lightGrey.withAlpha(120),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    dense: true,
                    child: ExpansionTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        trailing: int.parse(data.bookingStatus.toString()) >= 1
                            ? Icon(Icons.keyboard_arrow_down_outlined, size: 22.sp, color: Colors.black87,)
                            : Icon(Icons.block, size: 22.sp, color: Colors.grey,),
                        title: Text(
                          "Picked Up Image",
                          style: robotoRegular.copyWith(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        children: [
                          PickImages(bookingId: data.id.toString(), status: "2"),
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                Container(
                  decoration: BoxDecoration(
                    color: TColor.lightGrey.withAlpha(120),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    dense: true,
                    child: ExpansionTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        trailing: int.parse(data.bookingStatus.toString()) >= 2
                            ? Icon(Icons.keyboard_arrow_down_outlined, size: 22.sp, color: Colors.black87,)
                            : Icon(Icons.block, size: 22.sp, color: Colors.grey,),
                        title: Text(
                          "Under Service Image",
                          style: robotoRegular.copyWith(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        children: int.parse(data.bookingStatus.toString()) >= 2 ? [
                          UnderServiceImage(bookingId: data.id.toString(), status: '3',),
                        ] : []
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                Container(
                  decoration: BoxDecoration(
                    color: TColor.lightGrey.withAlpha(120),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: ListTileTheme(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    dense: true,
                    child: ExpansionTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        trailing: int.parse(data.bookingStatus.toString()) >= 3
                            ? Icon(Icons.keyboard_arrow_down_outlined, size: 22.sp, color: Colors.black87,)
                            : Icon(Icons.block, size: 22.sp, color: Colors.grey,),
                        title: Text(
                          "Ready Deliver Image",
                          style: robotoRegular.copyWith(color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        children: int.parse(data.bookingStatus.toString()) >= 3 ?  [
                          ReadyDeliverImage(bookingId: data.id.toString(), status: "4",),
                        ] : []
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                int.parse(data.bookingStatus.toString()) >= 4
                    ? Center(
                        child: InkWell(
                          onTap: ()async{
                            bool status = await detailsController.bookingStatusNetworkApi(data.id.toString(),"5");
                            if(status==true){
                              detailsController.getBookingDetailsNetworkApi(data.id.toString());
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40.0.h,
                            decoration: BoxDecoration(
                                color: TColor.green,
                                borderRadius: BorderRadius.circular(5.0.r)
                            ),
                            child: Text(int.parse(data.bookingStatus.toString()) >= 5?"Reached Now":"Reach Now",style: robotoMedium.copyWith(color: TColor.white),),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.0.h,
                          decoration: BoxDecoration(
                              color: TColor.lightGrey,
                              borderRadius: BorderRadius.circular(5.0.r)
                          ),
                          child: Text("Reached Now",style: robotoMedium.copyWith(color: TColor.black),),
                        ),
                      ),
                    SizedBox(height: 10.0.h),
                    Container(
                      decoration: BoxDecoration(
                        color: TColor.lightGrey.withAlpha(120),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: ListTileTheme(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        dense: true,
                        child: ExpansionTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                            trailing: int.parse(data.bookingStatus.toString()) >= 5 && detailsController.getBookingDetails.value.data.transectionList.isNotEmpty
                                ? Icon(Icons.keyboard_arrow_down_outlined, size: 22.sp, color: Colors.black87,)
                                : Icon(Icons.block, size: 22.sp, color: Colors.grey,),
                            title: Text(
                              "Delivered Image",
                              style: robotoRegular.copyWith(color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                            children: int.parse(data.bookingStatus.toString()) >= 5 && detailsController.getBookingDetails.value.data.transectionList.isNotEmpty ? [
                              DeliveredImage(bookingId: data.id.toString(), status: "6",),
                            ] : []
                        ),
                      ),
                    ),
                SizedBox(height: 20.0.h),
                Text("Payment details -", style: robotoMedium.copyWith(),),
                detailsController.getBookingDetails.value.data.transectionList.isNotEmpty?
                ListView.builder(
                  itemCount: detailsController.getBookingDetails.value.data.transectionList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                  var transectionList = detailsController.getBookingDetails.value.data.transectionList[index];
                  return ListTile(
                          leading: Image.asset(Images.money.toString(),height: 35.h, width: 35.0.w),
                          title: Text(transectionList.transactionId.toString(),overflow: TextOverflow.ellipsis,style: robotoMedium.copyWith(),),
                          subtitle: Text(transectionList.addDate.toString(),style: robotoText.copyWith(),),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transectionList.amount.toString(),style: robotoMedium.copyWith(),),
                              Text(transectionList.status == "1"?"Success":"Pending",style: robotoMedium.copyWith(color: TColor.green),),

                        ],
                      ),
                    );
                }) : Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.0.h),
                    child: Text("transection history not found!",style: robotoText.copyWith(),)
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
          );
        }
        ),
      )
    );
  }
}
