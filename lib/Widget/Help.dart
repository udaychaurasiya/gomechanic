// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/controller/login_controller.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    controller.getFaqNetworkApi();
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
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.to(() => const DashboardScreen()),
              icon: Icon(
                Icons.arrow_back,
                size: 22.sp,
              )),
          backgroundColor: TColor.themecolor,
          title: Text(
            "Help",
            style: robotoMedium.copyWith(
                fontSize: Dimensions.fontSizeLarge, color: Colors.white),
          ),
          leadingWidth: 30.w,
        ),
        body: Obx(() => controller.faqModel.value.data.isNotEmpty
            ? FadeInUp(
                delay: const Duration(milliseconds: 350),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, right: 4.w),
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: controller.faqModel.value.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data =
                                  controller.faqModel.value.data[index];
                              return Container(
                                margin: EdgeInsets.only(top: 3.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5.r, color: TColor.lightGrey),
                                    borderRadius: BorderRadius.circular(5.0.r)),
                                child: ExpansionTile(
                                  backgroundColor: TColor.lightGrey,
                                  textColor: TColor.black,
                                  iconColor: TColor.themecolor,
                                  collapsedTextColor: TColor.themecolor,
                                  title: Text(
                                    data.title.toString(),
                                    style: robotoText.copyWith(
                                        color: TColor.themecolor),
                                  ),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 5.0.h),
                                      // child: Html(
                                      //   data: data.description.toString(),
                                      //   style: {
                                      //     "body":
                                      //         Style(fontSize: FontSize(14.sp))
                                      //   },
                                      // ),
                                    ),
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              )
            : Container()),
      ),
    );
  }
}
