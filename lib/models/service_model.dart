// To parse this JSON data, do
//
//     final serviceDetailsModel = serviceDetailsModelFromJson(jsonString);

import 'dart:convert';

ServiceDetailsModel serviceDetailsModelFromJson(String str) => ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsModelToJson(ServiceDetailsModel data) => json.encode(data.toJson());

class ServiceDetailsModel {
  int? status;
  String? message;
  dynamic limit;
  int? page;
  List<Datum> data;

  ServiceDetailsModel({
    this.status,
    this.message,
    this.limit,
    this.page,
    required this.data,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) => ServiceDetailsModel(
    status: json["status"],
    message: json["message"],
    limit: json["limit"],
    page: json["page"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "limit": limit,
    "page": page,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? username;
  String? userProfile;
  String? id;
  String? tblUserId;
  String? adminMasterId;
  String? bookingNo;
  String? datumServiceType;
  String? ownerName;
  String? mobileNo;
  String? bikeCc;
  String? serviceDate;
  String? slotId;
  String? brandId;
  String? vinNoPic;
  String? idProve;
  String? bookingAddress;
  String? latitude;
  String? longitude;
  String? status;
  dynamic bookingStatus;
  String? addDate;
  dynamic modifyDate;
  String? serviceType;
  String? brandName;

  Datum({
    this.username,
    this.userProfile,
    this.id,
    this.tblUserId,
    this.adminMasterId,
    this.bookingNo,
    this.datumServiceType,
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    username: json["username"],
    userProfile: json["userProfile"],
    id: json["id"],
    tblUserId: json["tbl_user_id"],
    adminMasterId: json["admin_master_id"],
    bookingNo: json["booking_no"],
    datumServiceType: json["service_type"],
    ownerName: json["owner_name"],
    mobileNo: json["mobile_no"],
    bikeCc: json["bike_cc"],
    serviceDate: json["service_date"],
    slotId: json["slot_id"],
    brandId: json["brand_id"],
    vinNoPic: json["vin_no_pic"],
    idProve: json["id_prove"],
    bookingAddress: json["booking_address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    bookingStatus: json["booking_status"],
    addDate: json["add_date"],
    modifyDate: json["modify_date"],
    serviceType: json["serviceType"],
    brandName: json["brandName"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "userProfile": userProfile,
    "id": id,
    "tbl_user_id": tblUserId,
    "admin_master_id": adminMasterId,
    "booking_no": bookingNo,
    "service_type": datumServiceType,
    "owner_name": ownerName,
    "mobile_no": mobileNo,
    "bike_cc": bikeCc,
    "service_date": serviceDate,
    "slot_id": slotId,
    "brand_id": brandId,
    "vin_no_pic": vinNoPic,
    "id_prove": idProve,
    "booking_address": bookingAddress,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "booking_status": bookingStatus,
    "add_date": addDate,
    "modify_date": modifyDate,
    "serviceType": serviceType,
    "brandName": brandName,
  };
}
