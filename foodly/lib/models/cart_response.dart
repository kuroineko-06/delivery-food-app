import 'dart:convert';

List<CartResponse> cartResponseFromJson(String str) => List<CartResponse>.from(
    json.decode(str).map((x) => CartResponse.fromJson(x)));

String cartResponseToJson(List<CartResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartResponse {
  final String id;
  final String userId;
  final ProductId productId;
  final List<dynamic> additives;
  final double totalPrice;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  CartResponse({
    required this.id,
    required this.userId,
    required this.productId,
    required this.additives,
    required this.totalPrice,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["_id"],
        userId: json["userId"],
        productId: ProductId.fromJson(json["productId"]),
        additives: List<dynamic>.from(json["additives"].map((x) => x)),
        totalPrice: json["totalPrice"].toDouble(),
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "productId": productId.toJson(),
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "totalPrice": totalPrice,
        "quantity": quantity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class ProductId {
  final String id;
  final String title;
  final String restaurant;
  final double rating;
  final String ratingCount;
  final List<String> imageUrl;

  ProductId({
    required this.id,
    required this.title,
    required this.restaurant,
    required this.rating,
    required this.ratingCount,
    required this.imageUrl,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        title: json["title"],
        restaurant: json["restaurant"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["ratingCount"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "restaurant": restaurant,
        "rating": rating,
        "ratingCount": ratingCount,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
      };
}
