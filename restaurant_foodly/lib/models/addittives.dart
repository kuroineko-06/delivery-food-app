import 'dart:convert';

Addittives addittivesFromJson(String str) =>
    Addittives.fromJson(json.decode(str));

String addittivesToJson(Addittives data) => json.encode(data.toJson());

class Addittives {
  final int id;
  final String title;
  final String price;

  Addittives({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Addittives.fromJson(Map<String, dynamic> json) => Addittives(
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
