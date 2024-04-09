import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const robotoText = TextStyle(
  fontFamily: 'Proxima-Nova',
);

final robotoRegular = TextStyle(
  fontFamily: 'Proxima-Nova',

  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoMedium = TextStyle(
  fontFamily: 'Proxima-Nova',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoBold = TextStyle(
  fontFamily: 'Proxima-Nova',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault,
);

final robotoBlack = TextStyle(
  fontFamily: 'Proxima-Nova',
  fontWeight: FontWeight.w800,
  fontSize: Dimensions.fontSizeDefault,
);
final robotoBlack1 = TextStyle(
  fontFamily: 'Proxima-Nova',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.fontSizeDefault,
  color: const Color(0xFF03869D),
);

final  heading3= GoogleFonts.josefinSans(
  textStyle:const TextStyle(
    color:  Color(0xff000000),
    letterSpacing: 0.25,
    fontWeight: FontWeight.w700,
    height: 1.6,
  ),
  fontSize: 25.sp,
  fontWeight: FontWeight.w700,
);

final  titleStyle= GoogleFonts.josefinSans(
  textStyle:const TextStyle(
    color:  Color(0xff000000),
    fontWeight: FontWeight.w600,
  ),
  fontSize: 22.sp,
  fontWeight: FontWeight.w600,
);
final  subtitleStyle= GoogleFonts.josefinSans(
  textStyle:const TextStyle(
    color:  Color(0xff000000),
    fontWeight: FontWeight.w600,
  ),
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
);
final  bodyText1Style= GoogleFonts.josefinSans(
  textStyle:const TextStyle(
    color:  Color(0xff000000),
    fontWeight: FontWeight.w600,
  ),
  fontSize: 15.sp,
  fontWeight: FontWeight.w600,
);
final  bodyText2Style= GoogleFonts.josefinSans(
  textStyle:const TextStyle(
    color:  Color(0xff000000),
    fontWeight: FontWeight.w600,
  ),
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
);



final  smallTextStyle= GoogleFonts.josefinSans(
  textStyle: TextStyle(
    color:  const Color(0xff000000).withOpacity(0.7),
    fontSize: 14.sp,
    letterSpacing: 0.48,
    height: 1.25,
  ),
  fontWeight: FontWeight.w400,
);
final  bodyText3Style= GoogleFonts.josefinSans(
  textStyle:const TextStyle(
      color:  Color(0xff000000),
      letterSpacing: 1,
      height: 1.2
  ),
  fontSize: 14,
);
final  playfairDisplay= GoogleFonts.playfairDisplay(
  textStyle:const TextStyle(
    color:  Color(0xff000000),
    fontWeight: FontWeight.w600,
  ),
  fontSize: 22.sp,
  fontWeight: FontWeight.w600,
);

final BoxDecoration riderContainerDecoration = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
  color: Colors.blue.shade500.withOpacity(0.1), shape: BoxShape.rectangle,
);