
import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  int? status;
  String? message;
  List<Datum> data;

  ItemModel({
    this.status,
    this.message,
    required this.data,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
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
  String? image;
  dynamic totalBooking;
  int? allBooking;

  Datum({
    this.id,
    this.title,
    this.image,
    this.totalBooking,
    this.allBooking,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    totalBooking: json["totalBooking"],
    allBooking: json["allBooking"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "totalBooking": totalBooking,
    "allBooking": allBooking,
  };
}
