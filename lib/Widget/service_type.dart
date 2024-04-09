
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/Widget/service_subtype.dart';
import 'package:gomechanic/utils/all_image.dart';

class ServiceTypeWidget extends StatefulWidget {
  const ServiceTypeWidget({Key? key}) : super(key: key);

  @override
  State<ServiceTypeWidget> createState() => _ServiceTypeWidgetState();
}

List data = [
  'Full Service',
  'Half Service',
  'Only Service',
];

class _ServiceTypeWidgetState extends State<ServiceTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: ListView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => index == 0 ? _showBottomSheet() : null,
                child: Card(
                  child: SizedBox(
                    height: 60.0.h,
                    // color: Colors.blue,
                    child: ListTile(
                      leading: Image.asset(Images.splash),
                      title: Text(data[index]),
                      trailing: const Text(
                        'View',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> showBottom1() {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 180,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 3.0.h,
                  width: 50.0.w,
                  margin: const EdgeInsets.only(top: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black26,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 90.0.h,
                        width: 90.0.w,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1.0.w, color: Colors.grey.shade400)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60.0.h,
                              width: 60.0.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0.w,
                                      color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        Images.camera,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              'Camera',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 90.0.h,
                        width: 90.0.w,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1.0.w, color: Colors.grey.shade400)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60.0.h,
                              width: 60.0.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0.w,
                                      color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        Images.gallery,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 90.0.h,
                        width: 90.0.w,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1.0.w, color: Colors.grey.shade400)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60.0.h,
                              width: 60.0.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0.w,
                                      color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        Images.defaultProfile,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              'Remove',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet() {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      barrierColor: Colors.black.withOpacity(0.1),
      isScrollControlled: true,
      backgroundColor: Colors.grey.shade200,
      builder: (context) {
        return Container(
            padding: const EdgeInsets.all(10),
            height: h * 0.28,
            width: w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5.0.h,
                ),
                Container(
                  width: 40.0.w,
                  height: 4.0.h,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: 20.0.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const ServiceSubCategory())),
                        child: Container(
                          height: 100.0.h,
                          width: 100.0.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(width: 1.0.w, color: Colors.black),
                              image: const DecorationImage(
                                  image: AssetImage(Images.bikeService),
                                  fit: BoxFit.cover)),
                          child: Stack(
                            children: [
                              Positioned(
                                  bottom: 0.0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: TColor.lightGrey,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0))),
                                    child: Text(
                                      'Bike Service',
                                      style: TextStyle(color: TColor.black),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const ServiceSubCategory())),
                        child: Container(
                          height: 100.0.h,
                          width: 100.0.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(width: 1.0.w, color: Colors.black),
                              image: const DecorationImage(
                                  image: AssetImage(Images.engineService),
                                  fit: BoxFit.cover)),
                          child: Stack(
                            children: [
                              Positioned(
                                  bottom: 0.0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: TColor.lightGrey,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0))),
                                    child: Text(
                                      'Engine Service',
                                      style: TextStyle(color: TColor.black),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
