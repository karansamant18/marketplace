import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/helper/model/instrument_quote_model.dart';
import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_bx/helpers/user_model.dart';

Stream<bool> portfolioTokenSetStream = portfolioTokenSetSub.stream;
final StreamController<bool> portfolioTokenSetSub =
    StreamController<bool>.broadcast();

class HelperApi {
  Future<ResponseModel<InstrumentsQuoteModel>> instrumentQuotesApi({
    required dynamic quotes,
  }) async {
    if (!UserAuth().isJmClient()) {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
    // bool status = await HomeApiProvider().generateAccessToken();
    // if (status == false) {
    //   return ResponseModel(
    //     status: 400,
    //     data: null,
    //   );
    // }
    final response = await http.post(Uri.parse(ApiUrl.instrumentsQuoteAPi),
        body: json.encode(quotes),
        headers: {
          'Authorization': preferences.getString(Keys.marketDataToken) ?? "",
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: InstrumentsQuoteModel.fromJson(json.decode(response.body)),
      );
    } else {
      await preferences.setString(Keys.marketDataToken, "");
      HomeController().generateAccessTokenInitial();
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  //portfolio token
  static Future<void> generateAdvisoryToken() async {
    try {
      var body = {
        "data": {
          "mobileNumber": kDebugMode
              ? "8790928122"
              : preferences.getString(Keys.userPhoneNo),
          "userId": preferences.getString(Keys.userIdBlinkx),
          // "mobileNumber": preferences.getString(Keys.userPhoneNo),
          // "userId": preferences.getString(Keys.userId),
          "source": "ADVISOR"
        },
        "appID": "BARATH_TEST"
      };
      final response = await http.post(
        Uri.parse(
            "https://dev-ws.deh.blink.trade/Middleware/User/GenerateToken"),
        body: json.encode(body),
        headers: {'apiKey': 'mykey', 'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await updateAdvisoryToken(token: data["data"]["session"]);
        potfolioTokenSet();
      } else {
        await updateAdvisoryToken(token: "");
      }
    } catch (e) {
      await updateAdvisoryToken(token: "");
    }
  }

  static potfolioTokenSet() {
    if (preferences.getString(Keys.portfolioToken) != null &&
        preferences.getString(Keys.portfolioToken) != "") {
      portfolioTokenSetSub.sink.add(true);
    } else {
      portfolioTokenSetSub.sink.add(false);
    }
  }

  static updateAdvisoryToken({required String token}) async {
    await preferences.setString(Keys.portfolioToken, token);
  }

  //reset portfolio token
  Future<void> resetAdvisoryToken() async {
    try {
      var body = {
        "data": {
          "session": preferences.getString(Keys.portfolioToken),
          "totp": "{{totp}}"
        },
        "appID": "BARATH_TEST"
      };
      final response = await http.post(
        Uri.parse("https://dev-ws.deh.blink.trade/Middleware/User/ResetToken"),
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await updateAdvisoryToken(token: data["data"]["session"]);
        potfolioTokenSet();
      } else {
        await updateAdvisoryToken(token: "");
      }
    } catch (e) {
      await updateAdvisoryToken(token: "");
    }
  }
}

String? getAdvisoryToken() {
  String? token = preferences.getString(Keys.portfolioToken);
  return token;
}
