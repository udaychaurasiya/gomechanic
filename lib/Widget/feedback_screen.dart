import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Dashbord/dashboard.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/CoustomButton.dart';
import 'package:gomechanic/utils/custom_snackbar.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({Key? key}) : super(key: key);

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  List<String> dropdownItems = ['Problem 1', 'Problem 2', 'Problem 3', 'Problem 4'];
  RxString selectedValue = 'Problem 1'.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        await Get.to(()=> const DashboardScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=> Get.to(()=> const DashboardScreen()), icon: Icon(Icons.arrow_back, size: 22.sp,)),
          backgroundColor: TColor.themecolor,
          elevation: 0.0,
          title: Text(
            'Feedback',
            style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge, color: TColor.white),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0.h),
              Text(
                'Subject',
                style: robotoMedium.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: TColor.black,
                ),
              ),
              SizedBox(height: 15.0.h),
              Container(
                height: 40.0.h,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: TColor.lightGrey.withAlpha(150),
                  borderRadius: BorderRadius.circular(5.0.r),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      value: selectedValue.value,
                      items: dropdownItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        selectedValue.value = newValue!;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0.h),
              TextFormField(
                maxLines: null,
                minLines: 3,
                decoration: InputDecoration(
                    hintText: 'Your feedback',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0.w, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0.w, color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0.w, color: Colors.black)),
                ),
              ),
              SizedBox(height: 20.0.h,),
              Align(alignment: Alignment.centerRight, child: CustomButton(onPress: (){
                Get.offAll(()=> const DashboardScreen());
                CustomAnimation().showCustomSnackBar('Thanks you !',isError: false);
              }, title: "Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
