// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gomechanic/Widget/Color.dart';

class DialogHelper{
  static void showErroDialog({String title="Error",String ?description="Something went wrong "})
  {
    Get.dialog(
        Dialog(
            child:Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    title,
                    style: Get.textTheme.headline4,

                  ),
                  Text(
                    description!,
                    style: Get.textTheme.headline6,

                  ),
                  ElevatedButton(onPressed: (){
                    if (Get.isDialogOpen!) Get.back();
                  },
                      child:const Text("OK")
                  )
                ],
              ),
            )
        )
    );
  }
  static void showLoading(String? message) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CircularProgressIndicator(color: TColor.grey),),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}