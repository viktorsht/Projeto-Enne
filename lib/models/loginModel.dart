// To parse this JSON data, do
//
//     final loginApi = loginApiFromJson(jsonString);

import 'dart:convert';

LoginApi loginApiFromJson(String str) => LoginApi.fromJson(json.decode(str));

String loginApiToJson(LoginApi data) => json.encode(data.toJson());

class LoginApi {
    LoginApi({
        required this.status,
        required this.data,
    });

    String status;
    Data data;

    factory LoginApi.fromJson(Map<String, dynamic> json) => LoginApi(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.surname,
    });

    String id;
    String name;
    String surname;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
    };
}
