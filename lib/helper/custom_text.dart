import 'package:flutter/material.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class CustomTitleText extends StatelessWidget {
  final String text;
  const CustomTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w500, color: TColor.black.withAlpha(220)),
    );
  }
}


class CustomSubTitleText extends StatelessWidget {
  final String text;
  const CustomSubTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: TColor.black.withAlpha(150)),
    );
  }
}

