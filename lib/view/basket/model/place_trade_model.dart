// To parse this JSON data, do
//
//     final placeTradeModel = placeTradeModelFromJson(jsonString);

import 'dart:convert';

PlaceTradeModel placeTradeModelFromJson(String str) =>
    PlaceTradeModel.fromJson(json.decode(str));

// String placeTradeModelToJson(PlaceTradeModel data) => json.encode(data.toJson());

class PlaceTradeModel {
  Data? data;
  String? status;

  PlaceTradeModel({
    required this.data,
    required this.status,
  });

  factory PlaceTradeModel.fromJson(Map<String, dynamic> json) =>
      PlaceTradeModel(
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
