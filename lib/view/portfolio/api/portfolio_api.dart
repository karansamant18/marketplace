import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/view/helper/api/helper_api.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/holdings_model.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/portfolio_holdings_model.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/positions_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:http/http.dart' as http;

class PortfolioApi {
  Future<ResponseModel<HoldingsModel>> holdingsApi() async {
    final response = await http.post(Uri.parse(ApiUrl.holdingsApi), headers: {
      'apikey': Keys.apiKey,
      'Authorization':
          'Bearer ${preferences.getString(Keys.accessTokenBlinkx)}',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: HoldingsModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  Future<ResponseModel<PortfolioHoldings>> portfolioHoldingsApi() async {
    var headers = {
      'Authorization': 'Bearer ${preferences.getString(Keys.portfolioToken)}',
      'Content-Type': 'application/json'
    };
    var body = json.encode({"data": {}, "appID": "BARATH_TEST"});
    final response = await http.post(Uri.parse(ApiUrl.portfolioHoldingsApi),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: PortfolioHoldings.fromJson(json.decode(response.body)),
      );
    } else {
      if (response.body.toString().toLowerCase().contains("token")) {
        HelperApi().resetAdvisoryToken();
      }
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  Future<ResponseModel<PositionsModel>> netPositionsApi() async {
    final response =
        await http.post(Uri.parse(ApiUrl.netPositionsApi), headers: {
      'apikey': Keys.apiKey,
      'Authorization':
          'Bearer ${preferences.getString(Keys.accessTokenBlinkx)}',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: PositionsModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  Future<ResponseModel<PositionsModel>> dayPositionsApi() async {
    final response =
        await http.post(Uri.parse(ApiUrl.dayPositionsApi), headers: {
      'apikey': Keys.apiKey,
      'Authorization':
          'Bearer ${preferences.getString(Keys.accessTokenBlinkx)}',
      // 'Authorization':
      //     'Bearer ${preferences.getString(Keys.accessTokenBlinkx)}',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: PositionsModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }
}
