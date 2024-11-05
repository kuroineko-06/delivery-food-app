import 'dart:convert';

AddFoods addFoodsFromJson(String str) => AddFoods.fromJson(json.decode(str));

String addFoodsToJson(AddFoods data) => json.encode(data.toJson());

class AddFoods {
  final String title;
  final List<String> foodTags;
  final List<String> foodType;
  final String code;
  final String category;
  final String time;
  final bool isAvailable;
  final String restaurant;
  final double rating;
  final String ratingCount;
  final String description;
  final int countInStock;
  final double price;
  final List<Additive> additives;
  final List<String> imageUrl;

  AddFoods({
    required this.title,
    required this.foodTags,
    required this.foodType,
    required this.code,
    required this.category,
    required this.time,
    required this.isAvailable,
    required this.restaurant,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.countInStock,
    required this.price,
    required this.additives,
    required this.imageUrl,
  });

  factory AddFoods.fromJson(Map<String, dynamic> json) => AddFoods(
        title: json["title"],
        foodTags: List<String>.from(json["foodTags"].map((x) => x)),
        foodType: List<String>.from(json["foodType"].map((x) => x)),
        code: json["code"],
        category: json["category"],
        time: json["time"],
        isAvailable: json["isAvailable"],
        restaurant: json["restaurant"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        description: json["description"],
        countInStock: json["countInStock"],
        price: json["price"]?.toDouble(),
        additives: List<Additive>.from(
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
        "isAvailable": isAvailable,
        "restaurant": restaurant,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        "countInStock": countInStock,
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
