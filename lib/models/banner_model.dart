// To parse this JSON data, do
//
//     final bannerData = bannerDataFromJson(jsonString);

import 'dart:convert';

BannerData bannerDataFromJson(String str) => BannerData.fromJson(json.decode(str));

String bannerDataToJson(BannerData data) => json.encode(data.toJson());

class BannerData {
  int? status;
  String? message;
  List<Datum> data;

  BannerData({
    this.status,
    this.message,
    required this.data,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? title;
  String? amount;
  String? description;
  String? image;
  String? status;
  String? addDate;

  Datum({
    this.id,
    this.title,
    this.amount,
    this.description,
    this.image,
    this.status,
    this.addDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    amount: json["amount"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    addDate: json["add_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "amount": amount,
    "description": description,
    "image": image,
    "status": status,
    "add_date": addDate,
  };
}
