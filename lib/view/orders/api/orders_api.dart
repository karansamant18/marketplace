import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/view/orders/model/orders_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:http/http.dart' as http;

class OrdersApi {
  Future<ResponseModel<OrderModel>> orderBookApi() async {
    final response = await http.post(Uri.parse(ApiUrl.orderBookApi), headers: {
      'apikey': Keys.apiKey,
      'Authorization':
          'Bearer ${preferences.getString(Keys.accessTokenBlinkx)}',
    });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: OrderModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  Future<ResponseModel<bool>> cancelOrderApi({required String orderId}) async {
    final response = await http.post(Uri.parse(ApiUrl.cancelOrderApi),
        headers: {
          'apikey': Keys.apiKey,
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ${preferences.getString(Keys.accessTokenBlinkx)}',
        },
        body: json.encode({"orderid": orderId}));
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: json.decode(response.body)["status"],
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }
}
