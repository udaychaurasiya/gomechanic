import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  int? status;
  String? message;
  List<Datum> data;

  CategoryModel({
    this.status,
    this.message,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
  bool? isSelected;

  Datum({
    this.id,
    this.title,
    this.amount,
    this.description,
    this.image,
    this.status,
    this.addDate,
    this.isSelected,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    amount: json["amount"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    addDate: json["add_date"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "amount": amount,
    "description": description,
    "image": image,
    "status": status,
    "add_date": addDate,
    "isSelected": isSelected,
  };
}
