// To parse this JSON data, do
//
//     final savePresensiResponseModel = savePresensiResponseModelFromJson(jsonString);

import 'dart:convert';

CutiResponseModel CutiResponseModelFromJson(String str) =>
    CutiResponseModel.fromJson(json.decode(str));

String CutiResponseModelToJson(CutiResponseModel data) =>
    json.encode(data.toJson());

class CutiResponseModel {
  CutiResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory CutiResponseModel.fromJson(Map<String, dynamic> json) =>
      CutiResponseModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.tanggalmulai,
    required this.tanggalselesai,
    required this.jeniscuti,
    required this.keterangan,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  DateTime tanggalmulai;
  DateTime tanggalselesai;
  String jeniscuti;
  String keterangan;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        tanggalmulai: DateTime.parse(json["tanggal_mulai"]),
        tanggalselesai: DateTime.parse(json["tanggal_selesai"]),
        jeniscuti: json["jenis_cuti"],
        keterangan: json["keterangan"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "tanggal_mulai":
            "${tanggalmulai.year.toString().padLeft(4, '0')}-${tanggalmulai.month.toString().padLeft(2, '0')}-${tanggalmulai.day.toString().padLeft(2, '0')}",
        "tanggal_selesai":
            "${tanggalselesai.year.toString().padLeft(4, '0')}-${tanggalselesai.month.toString().padLeft(2, '0')}-${tanggalselesai.day.toString().padLeft(2, '0')}",
        "jenis_cuti": jeniscuti,
        "keterangan": keterangan,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
