import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gomechanic/Widget/Color.dart';
import 'package:gomechanic/utils/dimensions.dart';
import 'package:gomechanic/utils/style.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment History',
                style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault2, color: TColor.black),
              ),
              Text(
                'Your recent payment will show here',
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault, color: TColor.grey),
              ),
              SizedBox(height: 10.0.h,),
              ListView.builder(
                itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                return Column(
                  children: [
                    Text('${index + 1} DECEMBER 2023',style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault2, color: TColor.black),),
                    SizedBox(height: 10.0.h,),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: TColor.lightGrey,
                        child: Icon(Icons.phone_android_outlined,color: TColor.black,),
                      ),
                      title: const Text('Payment successfully'),
                      trailing: Text('2000 ₹',style: robotoRegular.copyWith(),),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
