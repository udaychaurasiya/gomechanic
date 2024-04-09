// To parse this JSON data, do
//
//     final shopOpenCloseModel = shopOpenCloseModelFromJson(jsonString);

import 'dart:convert';

ShopOpenCloseModel shopOpenCloseModelFromJson(String str) => ShopOpenCloseModel.fromJson(json.decode(str));

String shopOpenCloseModelToJson(ShopOpenCloseModel data) => json.encode(data.toJson());

class ShopOpenCloseModel {
  int? status;
  String? message;
  ShopOpenCloseData data;

  ShopOpenCloseModel({
    this.status,
    this.message,
    required this.data,
  });

  factory ShopOpenCloseModel.fromJson(Map<String, dynamic> json) => ShopOpenCloseModel(
    status: json["status"],
    message: json["message"],
    data: ShopOpenCloseData.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": data.toJson(),
  };
}

class ShopOpenCloseData {
  String? id;
  String? adminMasterId;
  String? userLogin;
  String? name;
  String? shopName;
  String? email;
  String? mobile;
  String? stateId;
  String? cityId;
  String? zipCode;
  String? address;
  String? description;
  String? latitude;
  String? longitude;
  String? mapAddress;
  String? isOnRoadService;
  String? idProveType;
  String? idProveNo;
  String? idProvePhoto;
  String? normalCcByck;
  String? heighPickup;
  String? byckServiceCapicity;
  String? storeTime;
  String? shopPhoto;
  String? status;
  String? shopOpen;
  DateTime? addDate;
  String? profile;

  ShopOpenCloseData({
    this.id,
    this.adminMasterId,
    this.userLogin,
    this.name,
    this.shopName,
    this.email,
    this.mobile,
    this.stateId,
    this.cityId,
    this.zipCode,
    this.address,
    this.description,
    this.latitude,
    this.longitude,
    this.mapAddress,
    this.isOnRoadService,
    this.idProveType,
    this.idProveNo,
    this.idProvePhoto,
    this.normalCcByck,
    this.heighPickup,
    this.byckServiceCapicity,
    this.storeTime,
    this.shopPhoto,
    this.status,
    this.shopOpen,
    this.addDate,
    this.profile,
  });

  factory ShopOpenCloseData.fromJson(Map<String, dynamic> json) => ShopOpenCloseData(
    id: json["id"],
    adminMasterId: json["admin_master_id"],
    userLogin: json["user_login"],
    name: json["name"],
    shopName: json["shop_name"],
    email: json["email"],
    mobile: json["mobile"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    zipCode: json["zip_code"],
    address: json["address"],
    description: json["description"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    mapAddress: json["map_address"],
    isOnRoadService: json["is_on_road_service"],
    idProveType: json["id_prove_type"],
    idProveNo: json["id_prove_no"],
    idProvePhoto: json["id_prove_photo"],
    normalCcByck: json["normal_cc_byck"],
    heighPickup: json["heigh_pickup"],
    byckServiceCapicity: json["byck_service_capicity"],
    storeTime: json["store_time"],
    shopPhoto: json["shop_photo"],
    status: json["status"],
    shopOpen: json["shop_open"],
    addDate: DateTime.parse(json["add_date"]),
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admin_master_id": adminMasterId,
    "user_login": userLogin,
    "name": name,
    "shop_name": shopName,
    "email": email,
    "mobile": mobile,
    "state_id": stateId,
    "city_id": cityId,
    "zip_code": zipCode,
    "address": address,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "map_address": mapAddress,
    "is_on_road_service": isOnRoadService,
    "id_prove_type": idProveType,
    "id_prove_no": idProveNo,
    "id_prove_photo": idProvePhoto,
    "normal_cc_byck": normalCcByck,
    "heigh_pickup": heighPickup,
    "byck_service_capicity": byckServiceCapicity,
    "store_time": storeTime,
    "shop_photo": shopPhoto,
    "status": status,
    "shop_open": shopOpen,
    "add_date": addDate!.toIso8601String(),
    "profile": profile,
  };
}
