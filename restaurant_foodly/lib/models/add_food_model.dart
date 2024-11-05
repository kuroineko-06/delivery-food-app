import 'dart:convert';
import 'package:restaurant_foodly/models/addittives.dart';

AddFoodModel addFoodModelFromJson(String str) =>
    AddFoodModel.fromJson(json.decode(str));

String addFoodModelToJson(AddFoodModel data) => json.encode(data.toJson());

class AddFoodModel {
  final String title;
  final List<String> foodTags;
  final List<String> foodType;
  final String code;
  final String category;
  final String time;
  final bool isAvailable;
  final String restaurant;
  final String description;
  final int countInStock;
  final double price;
  final List<Addittives> additives;
  final List<String> imageUrl;

  AddFoodModel({
    required this.title,
    required this.foodTags,
    required this.foodType,
    required this.code,
    required this.category,
    required this.time,
    required this.isAvailable,
    required this.restaurant,
    required this.description,
    required this.price,
    required this.countInStock,
    required this.additives,
    required this.imageUrl,
  });

  factory AddFoodModel.fromJson(Map<String, dynamic> json) => AddFoodModel(
        title: json["title"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        code: json["code"],
        category: json["category"],
        time: json["time"],
        isAvailable: json["isAvailable"],
        restaurant: json["restaurant"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        countInStock: json["countInStock"],
        additives: List<Addittives>.from(
            json["additives"].map((x) => Additive.fromJson(x))),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
        "foodType": List<dynamic>.from(foodType.map((x) => x)),
        "code": code,
        "category": category,
        "time": time,
        "countInStock": countInStock,
        "isAvailable": isAvailable,
        "restaurant": restaurant,
        "description": description,
        "price": price,
        "additives": List<dynamic>.from(additives.map((x) => x.toJson())),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
      };
}

class Additive {
  final int id;
  final String title;
  final String price;

  Additive({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Additive.fromJson(Map<String, dynamic> json) => Additive(
        id: json["id"],
        title: json["title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
      };
}
