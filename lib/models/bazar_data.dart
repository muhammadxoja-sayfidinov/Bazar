import 'dart:convert';

import 'package:flutter/material.dart';

// Bazar bazarFromJson(String str) => Bazar.fromJson(json.decode(str));
//
// String bazarToJson(Bazar data) => json.encode(data.toJson());

// class Bazar {
//     Bazar({
//         this.status,
//         this.data,
//         this.message,
//     });
//
//     int? status;
//     List<Datum>? data;
//     String? message;
//
//     factory Bazar.fromJson(Map<String, dynamic> json) => Bazar(
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

class Bazar with ChangeNotifier {
  final String bazarId;
  final String bazarName;
  final String bazarImage;
  final bool isActive;
  final DateTime createdAt;
  Bazar({
    required this.bazarId,
    required this.bazarName,
    required this.bazarImage,
    required this.isActive,
    required this.createdAt,
  });

  // factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  //     bazarId: json["bazar_id"],
  //     bazarName: json["bazar_name"],
  //     bazarImage: json["bazar_image"],
  //     isActive: json["is_active"],
  //     createdAt: DateTime.parse(json["created_at"]),
  // );
  //
  // Map<String, dynamic> toJson() => {
  //     "bazar_id": bazarId,
  //     "bazar_name": bazarName,
  //     "bazar_image": bazarImage,
  //     "is_active": isActive,
  //     "created_at": createdAt!.toIso8601String(),
  // };
}
