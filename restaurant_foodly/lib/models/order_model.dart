import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  final String id;
  final UserId userId;
  final List<OrderItem> orderItems;
  final double deliveryFee;
  final DeliveryAddress deliveryAddress;
  final String orderStatus;
  final RestaurantId restaurantId;
  final List<double> restaurantCoords;
  final List<double> recipientCoords;

  OrderModel({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.deliveryFee,
    required this.deliveryAddress,
    required this.orderStatus,
    required this.restaurantId,
    required this.restaurantCoords,
    required this.recipientCoords,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        deliveryFee: json["deliveryFee"]?.toDouble(),
        deliveryAddress: DeliveryAddress.fromJson(json["deliveryAddress"]),
        orderStatus: json["orderStatus"],
        restaurantId: RestaurantId.fromJson(json["restaurantId"]),
        restaurantCoords: List<double>.from(
            json["restaurantCoords"].map((x) => x?.toDouble())),
        recipientCoords: List<double>.from(
            json["recipientCoords"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "deliveryFee": deliveryFee,
        "deliveryAddress": deliveryAddress.toJson(),
        "orderStatus": orderStatus,
        "restaurantId": restaurantId.toJson(),
        "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
        "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
      };
}

class DeliveryAddress {
  final String id;
  final String addressLine1;

  DeliveryAddress({
    required this.id,
    required this.addressLine1,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(id: json['_id'], addressLine1: json['addressLine1']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "addressLine1": addressLine1,
      };
}

class OrderItem {
  final FoodId foodId;

  OrderItem({
    required this.foodId,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: FoodId.fromJson(json["foodId"]),
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId.toJson(),
      };
}

class FoodId {
  final String id;
  final String title;
  final String time;
  final List<String> imageUrl;

  FoodId({
    required this.id,
    required this.title,
    required this.time,
    required this.imageUrl,
  });

  factory FoodId.fromJson(Map<String, dynamic> json) => FoodId(
        id: json["_id"],
        title: json["title"],
        time: json["time"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "time": time,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
      };
}

class RestaurantId {
  final Coords coords;
  final String id;
  final String title;
  final String imageUrl;
  final String logoUrl;
  final String time;

  RestaurantId({
    required this.coords,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.logoUrl,
    required this.time,
  });

  factory RestaurantId.fromJson(Map<String, dynamic> json) => RestaurantId(
        coords: Coords.fromJson(json["coords"]),
        id: json["_id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        logoUrl: json["logoUrl"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "coords": coords.toJson(),
        "_id": id,
        "title": title,
        "imageUrl": imageUrl,
        "logoUrl": logoUrl,
        "time": time,
      };
}

class Coords {
  final String id;
  final double latitude;
  final double longitude;
  final String address;
  final String title;

  Coords({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.title,
  });

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
        id: json["id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "title": title,
      };
}

class UserId {
  final String id;
  final String phone;
  final String profile;

  UserId({
    required this.id,
    required this.phone,
    required this.profile,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        phone: json["phone"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "profile": profile,
      };
}
