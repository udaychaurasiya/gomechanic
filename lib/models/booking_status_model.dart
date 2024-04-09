// To parse this JSON data, do
//
//     final bookingStatusModel = bookingStatusModelFromJson(jsonString);

import 'dart:convert';

BookingStatusModel bookingStatusModelFromJson(String str) => BookingStatusModel.fromJson(json.decode(str));

String bookingStatusModelToJson(BookingStatusModel data) => json.encode(data.toJson());

class BookingStatusModel {
  int? status;
  String? message;
  DetailsData data;

  BookingStatusModel({
    this.status,
    this.message,
    required this.data,
  });

  factory BookingStatusModel.fromJson(Map<String, dynamic> json) => BookingStatusModel(
    status: json["status"],
    message: json["message"],
    data: DetailsData.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": data.toJson(),
  };
}

class DetailsData {
  String? username;
  String? userProfile;
  String? id;
  String? tblUserId;
  String? adminMasterId;
  String? bookingNo;
  String? dataServiceType;
  String? ownerName;
  String? mobileNo;
  String? bikeCc;
  DateTime? serviceDate;
  String? slotId;
  String? brandId;
  String? vinNoPic;
  String? idProve;
  String? bookingAddress;
  String? latitude;
  String? longitude;
  String? status;
  String? bookingStatus;
  DateTime? addDate;
  dynamic modifyDate;
  String? serviceType;
  String? brandName;
  List<Image> pickedupImage;
  List<Image> underServiceImage;
  List<Image> readyDeliverImage;
  List<Image> deliveredImage;
  List<TransectionList> transectionList;

  DetailsData({
    this.username,
    this.userProfile,
    this.id,
    this.tblUserId,
    this.adminMasterId,
    this.bookingNo,
    this.dataServiceType,
    this.ownerName,
    this.mobileNo,
    this.bikeCc,
    this.serviceDate,
    this.slotId,
    this.brandId,
    this.vinNoPic,
    this.idProve,
    this.bookingAddress,
    this.latitude,
    this.longitude,
    this.status,
    this.bookingStatus,
    this.addDate,
    this.modifyDate,
    this.serviceType,
    this.brandName,
    required this.pickedupImage,
    required this.underServiceImage,
    required this.readyDeliverImage,
    required this.deliveredImage,
    required this.transectionList,
  });

  factory DetailsData.fromJson(Map<String?, dynamic> json) => DetailsData(
    username: json["username"],
    userProfile: json["userProfile"],
    id: json["id"],
    tblUserId: json["tbl_user_id"],
    adminMasterId: json["admin_master_id"],
    bookingNo: json["booking_no"],
    dataServiceType: json["service_type"],
    ownerName: json["owner_name"],
    mobileNo: json["mobile_no"],
    bikeCc: json["bike_cc"],
    serviceDate: DateTime.parse(json["service_date"]),
    slotId: json["slot_id"],
    brandId: json["brand_id"],
    vinNoPic: json["vin_no_pic"],
    idProve: json["id_prove"],
    bookingAddress: json["booking_address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    bookingStatus: json["booking_status"],
    addDate: DateTime.parse(json["add_date"]),
    modifyDate: json["modify_date"],
    serviceType: json["serviceType"],
    brandName: json["brandName"],
    pickedupImage: List<Image>.from(json["pickedup_image"].map((x) => Image.fromJson(x))),
    underServiceImage: List<Image>.from(json["under_service_image"].map((x) => Image.fromJson(x))),
    readyDeliverImage: List<Image>.from(json["ready_deliver_image"].map((x) => Image.fromJson(x))),
    deliveredImage: List<Image>.from(json["delivered_image"].map((x) => Image.fromJson(x))),
    transectionList: List<TransectionList>.from(json["transection_list"].map((x) => TransectionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "userProfile": userProfile,
    "id": id,
    "tbl_user_id": tblUserId,
    "admin_master_id": adminMasterId,
    "booking_no": bookingNo,
    "service_type": dataServiceType,
    "owner_name": ownerName,
    "mobile_no": mobileNo,
    "bike_cc": bikeCc,
    "service_date": "${serviceDate!.year.toString().padLeft(4, '0')}-${serviceDate!.month.toString().padLeft(2, '0')}-${serviceDate!.day.toString().padLeft(2, '0')}",
    "slot_id": slotId,
    "brand_id": brandId,
    "vin_no_pic": vinNoPic,
    "id_prove": idProve,
    "booking_address": bookingAddress,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "booking_status": bookingStatus,
    "add_date": addDate!.toIso8601String(),
    "modify_date": modifyDate,
    "serviceType": serviceType,
    "brandName": brandName,
    "pickedup_image": List<dynamic>.from(pickedupImage.map((x) => x.toJson())),
    "under_service_image": List<dynamic>.from(underServiceImage.map((x) => x.toJson())),
    "ready_deliver_image": List<dynamic>.from(readyDeliverImage.map((x) => x.toJson())),
    "delivered_image": List<dynamic>.from(deliveredImage.map((x) => x.toJson())),
    "transection_list": List<dynamic>.from(transectionList.map((x) => x.toJson())),
  };
}

class Image {
  String? id;
  DateTime? addDate;
  String? image;

  Image({
    this.id,
    this.addDate,
    this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    addDate: DateTime.parse(json["add_date"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "add_date": "${addDate!.year.toString().padLeft(4, '0')}-${addDate!.month.toString().padLeft(2, '0')}-${addDate!.day.toString().padLeft(2, '0')}",
    "image": image,
  };
}

class TransectionList {
  String? id;
  String? transactionId;
  String? amount;
  String? remark;
  String? status;
  DateTime? addDate;

  TransectionList({
    this.id,
    this.transactionId,
    this.amount,
    this.remark,
    this.status,
    this.addDate,
  });

  factory TransectionList.fromJson(Map<String, dynamic> json) => TransectionList(
    id: json["id"],
    transactionId: json["transaction_id"],
    amount: json["amount"],
    remark: json["remark"],
    status: json["status"],
    addDate: DateTime.parse(json["add_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "amount": amount,
    "remark": remark,
    "status": status,
    "add_date": addDate!.toIso8601String(),
  };
}
