
import 'package:e_commerce_friday_c9/data/model/response/api_error.dart';

class AuthResponse {
  String? message;
  User? user;
  String? token;
  ApiError? errors;

  AuthResponse({this.message, this.user, this.errors, this.token});

  AuthResponse.fromJson(dynamic json) {
    message = json["message"];
    user = json["user"] != null ? User.fromJson(json["user"]) : null;
    errors = json["errors"] != null ? ApiError.fromJson(json["errors"]) : null;
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = message;
    if (user != null) {
      map["user"] = user?.toJson();
    }
    if (errors != null) {
      map["errors"] = errors?.toJson();
    }
    map["token"] = token;
    return map;
  }
}

class User {
  String? name;
  String? email;
  String? role;

  User({this.name, this.email, this.role});

  User.fromJson(dynamic json) {
    name = json["name"];
    email = json["email"];
    role = json["role"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["role"] = role;
    return map;
  }
}
