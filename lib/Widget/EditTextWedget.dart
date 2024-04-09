// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';
class EditTextWidget extends StatelessWidget {
  final TextEditingController ?controller;
  final String hint;
  final int? maxLines;
  final int? minLines;
  final Widget? label;
  final Function(String)? onChange;
  final TextInputType ?type;
  final FormFieldValidator? validator;
  final int ?length;
  final bool ?isRead;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? border;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  const EditTextWidget({Key? key,  this.controller,required this.hint, this.validator, this.type=TextInputType.text, this.length, this.isRead=false, this.onChange, this.inputFormatters, this.suffixIcon, this.prefixIcon, this.label, this.border, this.onTap, this.maxLines, this.minLines,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller:controller,
        readOnly: isRead!,
        inputFormatters: inputFormatters,
        onTap: onTap,
        maxLines: maxLines,
        minLines: minLines,
        decoration:  InputDecoration(
          border: border,
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: TColor.lightGrey.withAlpha(150), width: 0.5.w),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: TColor.black),
          ),
          hintText: hint,
          label: label,
          labelStyle: robotoRegular.copyWith(color: TColor.black.withAlpha(150), fontSize: Dimensions.fontSizeDefault),
          isDense: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          counter: const Offstage(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),

        ),
        onChanged: onChange,
        keyboardType: type,
        validator:validator ,
        maxLength: length,
        style: robotoMedium.copyWith(color: TColor.black.withAlpha(180)));
  }
}
