import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final  Function()? onTap;
  const CustomListTile({Key? key, required this.text, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: Dimensions.fontSizeOverLarge,
              color:TColor.grey.withAlpha(200),
            ),
            SizedBox(width: 20.0.w),
            Text(
              text,
              style: robotoMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraLarge,
                  color: text == 'Logout' ? TColor.red.withAlpha(200) : TColor.black.withAlpha(180)),
            ),
          ],
        ),
      ),
    );
  }
}
