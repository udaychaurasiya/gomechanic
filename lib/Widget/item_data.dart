import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/all_details.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:shimmer/shimmer.dart';

class ItemData extends StatefulWidget {
  const ItemData({Key? key}) : super(key: key);

  @override
  State<ItemData> createState() => _ItemDataState();
}

class _ItemDataState extends State<ItemData> {
  LoginController controller = Get.put(LoginController());
  DetailsController detailsController = Get.put(DetailsController());
  @override
  void initState() {
    controller.getVendorItemDataCountNetworkApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      {
        return controller.itemData.value.data.isNotEmpty
            ? GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                shrinkWrap: true,
                children: List.generate(
                  controller.itemData.value.data.length,
                  (index) {
                    var itemDataCount = controller.itemData.value.data[index];
                    return Builder(
                      builder: (BuildContext context) => GestureDetector(
                        child: InkWell(
                          onTap: () async {
                            if(controller.itemData.value.data[index].totalBooking.toString() != "0"){
                            if (controller.itemData.value.data[index].id ==
                                    "All" ||
                                controller.itemData.value.data[index].id ==
                                    "Pending" ||
                                controller.itemData.value.data[index].id ==
                                    "Completed" ||
                                controller.itemData.value.data[index].id ==
                                    "Rejected") {
                                controller.selectTtlValue.value = controller.itemData.value.data[index].id.toString();
                                detailsController.getBookDetailsNetworkApi("", controller.selectTtlValue.value,"");
                                controller.getListItemDataCountNetworkApi();
                                detailsController.currentPage.value = 0;
                                Get.to(() => const DashboardDetails());
                            } else {
                                controller.selectTtlValue.value = "All";
                                controller.getListItemDataCountNetworkApi();
                                detailsController.getBookDetailsNetworkApi(
                                    itemDataCount.id.toString().trim(), "","");
                                detailsController.currentPage.value = 0;
                                Get.to(() => const DashboardDetails());
                              }
                            }else{
                              CustomAnimation().showCustomToast("No data found!!", isError: true);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0.r),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0.r),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: TColor.Text.withAlpha(120),
                                    blurRadius: 0.80,
                                    offset: const Offset(0.80, 0.80))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  AppConstants.BASE_URL +
                                      itemDataCount.image.toString(),
                                  height: 20.0.h,
                                  width: 20.0.w,
                                ),
                                // SizedBox(height: 5.0.h),
                                Text(
                                  itemDataCount.title.toString(),
                                  style: robotoMedium.copyWith(
                                      color: TColor.themecolor,
                                      fontSize: Dimensions.fontSizeSmall),
                                  textAlign: TextAlign.center,
                                ),
                                // SizedBox(height: 5.0.h),
                                CircleAvatar(
                                  backgroundColor:
                                      TColor.themecolor.withOpacity(0.9),
                                  radius: 16,
                                  child: Text(
                                    "${itemDataCount.totalBooking ?? 0}",
                                    style: robotoMedium.copyWith(
                                        color: TColor.white,
                                        fontSize: Dimensions.fontSizeSmall),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                //childAspectRatio: 5/4,
                shrinkWrap: true,
                children: List.generate(
                  15,
                  (index) {
                    return Builder(
                      builder: (BuildContext context) => GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(12.0.r),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: TColor.Text.withAlpha(120),
                                  blurRadius: 0.80,
                                  offset: const Offset(0.80, 0.80))
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
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
                                          BorderRadius.circular(5.0.r),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0.h),
                              Shimmer.fromColors(
                                baseColor: TColor.themecolor.withOpacity(0.1),
                                highlightColor: TColor.themecolor.withAlpha(80),
                                direction: ShimmerDirection.ltr,
                                period: const Duration(seconds: 2),
                                child: Container(
                                  height: 20,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5.0.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
      }
    });
  }
}
