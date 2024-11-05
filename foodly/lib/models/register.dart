import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final String username;
  final String email;
  final String password;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
