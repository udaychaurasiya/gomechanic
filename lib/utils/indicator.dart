import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomechanic/Widget/Color.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: [
            BoxShadow(
              color: TColor.grey.withOpacity(0.5),
              blurRadius: 5.0.r, spreadRadius: 2.r,
            ),
          ],
        ),
        child: SizedBox(
          height: 30.r,
          width: 30.r,
          child: CircularProgressIndicator(color: TColor.themecolor, strokeWidth: 3.5.r,),
        ),
      ),
    );
  }
}
