// To parse this JSON data, do
//
//     final investInBasektModel = investInBasektModelFromJson(jsonString);

import 'dart:convert';

InvestInBasektModel investInBasektModelFromJson(String str) =>
    InvestInBasektModel.fromJson(json.decode(str));

// String investInBasektModelToJson(InvestInBasektModel data) =>
//     json.encode(data.toJson());

class InvestInBasektModel {
  Data? data;
  String? status;

  InvestInBasektModel({
    required this.data,
    required this.status,
  });

  factory InvestInBasektModel.fromJson(Map<String, dynamic> json) =>
      InvestInBasektModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
      );
}

class Data {
  String? basketOrderStr;
  String? gatewayName;
  String? orderId;
  String? scToken;
  String? transactionId;

  Data({
    required this.basketOrderStr,
    required this.gatewayName,
    required this.orderId,
    required this.scToken,
    required this.transactionId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basketOrderStr: json["basketOrderStr"],
        gatewayName: json["gatewayName"],
        orderId: json["orderID"],
        scToken: json["scToken"],
        transactionId: json["transactionID"],
      );
}
