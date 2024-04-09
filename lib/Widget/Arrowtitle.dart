// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomechanic/utils/style.dart';
class ArrowTitleBar extends StatelessWidget {
  final String title;
  const ArrowTitleBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 15.0.w,),
        RawMaterialButton(onPressed: (){
          Navigator.pop(context);
        },
          fillColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.all(8),
          shape: const CircleBorder(side: BorderSide(color: Colors.black,width: 0.8)),
          constraints: const BoxConstraints(maxHeight: 40,maxWidth: 40),
          child: const Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 20,),
        ),
        const SizedBox(width: 8,),
        Expanded( flex:6,child: Padding(
          padding: const EdgeInsets.only(top: 10.0,left: 10),
          child: Text(title,style: titleStyle,),
        ))
      ],
    );
  }
}
