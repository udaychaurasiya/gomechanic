// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final Color? color;
  const CustomButton({super.key, this.onPressed, @required this.buttonText, this.transparent = false, this.margin, this.width, this.height,
    this.fontSize, this.radius = 5, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparent
          ? Colors.transparent : color ?? Theme.of(context).primaryColor,
      minimumSize: Size(width!,  height!),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(child: SizedBox(width: width, child: Padding(
      padding: const EdgeInsets.all(0),
      child: TextButton(
        style: _flatButtonStyle,
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null ? Padding(
            padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Icon(icon, color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
          ) : const SizedBox(),
          Text(buttonText ??'', textAlign: TextAlign.center, style: robotoBold.copyWith(
            color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
            fontSize: fontSize,
          )),
        ]),
      ),
    )));
  }
}
