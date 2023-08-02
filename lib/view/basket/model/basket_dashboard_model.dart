// To parse this JSON data, do
//
//     final basketDashboardModel = basketDashboardModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_mobile_bx/view/basket/model/post_trade_model.dart';

BasketDashboardModel basketDashboardModelFromJson(String str) =>
    BasketDashboardModel.fromJson(json.decode(str));

// String basketDashboardModelToJson(BasketDashboardModel data) => json.encode(data.toJson());

class BasketDashboardModel {
  String status;
  List<InvestedBasket> data;

  BasketDashboardModel({
    required this.status,
    required this.data,
  });

  factory BasketDashboardModel.fromJson(Map<String, dynamic> json) =>
      BasketDashboardModel(
        status: json["status"],
        data: List<InvestedBasket>.from(
            json["data"].map((x) => InvestedBasket.fromJson(x))),
      );
}
