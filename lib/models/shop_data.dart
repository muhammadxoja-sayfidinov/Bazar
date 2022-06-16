import 'dart:convert';

import 'package:flutter/material.dart';

// Shop shopFromJson(String str) => Shop.fromJson(json.decode(str));
//
// String shopToJson(Shop data) => json.encode(data.toJson());
//
// class Shop {
//     Shop({
//         this.status,
//         this.data,
//         this.message,
//     });
//
//     int? status;
//     List<Datum>? data;
//     String? message;
//
//     factory Shop.fromJson(Map<String, dynamic> json) => Shop(
//         status: json["status"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         message: json["message"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//         "message": message,
//     };
// }

class ShopDate with ChangeNotifier {
    final String shopId;
    final String shopName;
    final String shopPhone;
    final String shopImage;
    final String bazarId;
    final bool isActive;
    final DateTime createdAt;
    final String bazarName;
    ShopDate({
    required this.shopId,
    required this.shopName,
    required this.shopPhone,
    required this.shopImage,
    required this.bazarId,
    required this.isActive,
    required this.createdAt,
    required this.bazarName,
  });



  // factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  //     shopId: json["shop_id"],
  //     shopName: json["shop_name"],
  //     shopPhone: json["shop_phone"],
  //     shopImage: json["shop_image"],
  //     bazarId: json["bazar_id"],
  //     isActive: json["is_active"],
  //     createdAt: DateTime.parse(json["created_at"]),
  //     bazarName: json["bazar_name"],
  // );
  //
  // Map<String, dynamic> toJson() => {
  //     "shop_id": shopId,
  //     "shop_name": shopName,
  //     "shop_phone": shopPhone,
  //     "shop_image": shopImage,
  //     "bazar_id": bazarId,
  //     "is_active": isActive,
  //     "created_at": createdAt!.toIso8601String(),
  //     "bazar_name": bazarName,
  // };
}
