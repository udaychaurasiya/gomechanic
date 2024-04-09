import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/EditTextWedget.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class ServiceSubCategory extends StatefulWidget {
  const ServiceSubCategory({Key? key}) : super(key: key);

  @override
  State<ServiceSubCategory> createState() => _ServiceSubCategoryState();
}

class _ServiceSubCategoryState extends State<ServiceSubCategory> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(right: 0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                EditTextWidget(
                                  hint: 'Name',
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please Enter Name";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextWidget(
                                  hint: 'Mobile',
                                  type: TextInputType.phone,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please enter mobile";
                                    }
                                    if (value.toString().length != 10) {
                                      return "Please enter 10 digit Number";
                                    }
                                    return null;
                                  },
                                  length: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextWidget(
                                  hint: 'Engine Number',
                                  type: TextInputType.phone,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please enter engine Number";
                                    }
                                    return null;
                                  },
                                  length: 12,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextWidget(
                                  hint: 'Email',
                                  type: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please Enter Email";
                                    }
                                    if (!GetUtils.isEmail(value)) {
                                      return "Please Enter Valid Email";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextWidget(
                                  hint: 'Enter Date',
                                  type: TextInputType.text,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Please enter current date";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TColor.lightGrey,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Upload Image',
                                      style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: TColor.black),
                                    )),
                                SizedBox(
                                  height: 50.0.h,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 10.0,
                                  ),
                                  alignment: Alignment.bottomRight,
                                  width: Get.width,
                                  child: RawMaterialButton(
                                    onPressed: () =>
                                        formKey.currentState!.validate(),
                                    fillColor: Colors.black,
                                    padding: const EdgeInsets.all(8),
                                    shape: const CircleBorder(),
                                    constraints: const BoxConstraints(
                                        maxHeight: 54, maxWidth: 54),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
