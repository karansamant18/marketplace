import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/view/buy_stock/model/order_limit_model.dart';
import 'package:flutter_mobile_bx/view/buy_stock/model/req_margin_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_bx/view/buy_stock/model/place_order_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class PlaceOrderApi {
  Future<ResponseModel<PlaceOrderModel>> placeOrderApi({
    required Map<String, dynamic> orderData,
  }) async {
    var token = preferences.getString(Keys.accessTokenBlinkx);
    debugPrint("$token");
    final response = await http.post(Uri.parse(ApiUrl.placeOrderApi),
        body: json.encode(orderData),
        headers: {
          'apikey': Keys.apiKey,
          'Authorization':
              "Bearer ${preferences.getString(Keys.accessTokenBlinkx)}",
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: PlaceOrderModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  Future<ResponseModel<OrderLimitsModel>> orderLimitsApi(
      Map<String, String> object) async {
    final response = await http.post(Uri.parse(ApiUrl.orderLimitsApi),
        body: json.encode(object),
        headers: {
          'apikey': Keys.apiKey,
          'Authorization':
              'Bearer ${preferences.getString(Keys.accessTokenBlinkx)}',
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: OrderLimitsModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  Future<ResponseModel<ReqMarginModel>> reqMarginApi(
      Map<String, dynamic> object) async {
    final response = await http.post(Uri.parse(ApiUrl.reqMarginApi),
        body: json.encode(object),
        headers: {
          // 'apikey': Keys.apiKey,
          'Authorization':
              'Bearer ${preferences.getString(Keys.portfolioToken)}',
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: ReqMarginModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }
}
