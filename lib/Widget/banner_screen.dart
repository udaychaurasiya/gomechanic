import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/app_constants.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
import 'package:shimmer/shimmer.dart';

class BannerView extends StatelessWidget {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(builder: (controller) {
    List<dynamic> bannerList = controller.bannerData.value.data;
      return (bannerList.isNotEmpty && bannerList.isEmpty) ? const SizedBox() : SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.45,
        // padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
        child: bannerList.isNotEmpty
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                  height: 150.0.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: 1.0,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    controller.setCurrentIndex(index, true);
                  },
                ),
                items: controller.bannerData.value.data.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        height: 149.0.h,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            left: 10.0,
                            right: 10,
                            top: 10,
                            bottom: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0.r),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                color:
                                Color.fromRGBO(0, 0, 0, 0.20),
                              )
                            ],
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(
                                    AppConstants.BASE_URL +
                                        i.image.toString()),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                top: 70, left: 8.0, right: 8.0, bottom: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                            child: Text(i.title.toString(),
                                style: robotoRegular.copyWith(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                        .withAlpha(240))),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerList.map((bnr) {
                int index = bannerList.indexOf(bnr);
                return TabPageSelectorIndicator(
                  backgroundColor: index == controller.currentIndex.value ? TColor.Text.withOpacity(0.8)
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                  borderColor: Theme.of(context).colorScheme.background,
                  size: index == controller.currentIndex.value ? 10 : 7,
                );
              }).toList(),
            ),

          ],
            )
            : Shimmer.fromColors(
              baseColor: TColor.themecolor.withOpacity(0.1),
              highlightColor: TColor.themecolor.withAlpha(80),
              direction: ShimmerDirection.ltr,
              period: const Duration(seconds: 2),
              child: Container(margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0), decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                color: Colors.grey[200],
              )),
        ),
      );
    });
  }

}