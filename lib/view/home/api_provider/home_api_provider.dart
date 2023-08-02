import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/view/home/model/home_quote_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class HomeApiProvider {
  //generatetoken
  Future<bool> generateAccessTokenInitial() async {
    final res = await http.get(Uri.parse(ApiUrl.firstTokenApi));
    if (res.statusCode == 200) {
      preferences.setString(Keys.marketDataAccesstoken,
          json.decode(res.body)["description"]["accessToken"]);
      return true;
    } else {
      preferences.setString(Keys.marketDataAccesstoken, "");
      return false;
    }
  }

  //generatetoken
  Future<bool> generateAccessToken() async {
    final res = await http.post(Uri.parse(ApiUrl.secondTokenApi),
        body: json.encode({
          "source": " ",
          "deviceID": preferences.getString(Keys.userPhoneNo),
          "accessToken": preferences.getString(Keys.marketDataAccesstoken),
        }),
        headers: {"Content-Type": "application/json"});
    if (res.statusCode == 200) {
      preferences.setString(
          Keys.marketDataToken, json.decode(res.body)["result"]["token"]);
      return true;
    } else {
      preferences.setString(Keys.marketDataToken, "");
      return false;
    }
  }

  // Future<ResponseModel<ClientConfigModel>> generateTokenClientConfig() async {
  //   bool status = await generateAccessToken();
  //   if (status == false) {
  //     return ResponseModel(
  //       status: 400,
  //       data: null,
  //     );
  //   }
  //   final response = await http.get(
  //     Uri.parse(ApiUrl.clientConfigAPi),
  //     headers: {
  //       'Authorization': preferences.getString(Keys.marketDataToken) ?? "",
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return ResponseModel(
  //       status: 200,
  //       data: ClientConfigModel.fromJson(json.decode(response.body)),
  //     );
  //   } else {
  //     return ResponseModel(
  //       status: 400,
  //       data: null,
  //     );
  //   }
  // }

  //Get Quote Api
  Future<ResponseModel<List<HomeQuoteModel>>> getQuoteApi() async {
    final response = await http.get(
      Uri.parse(ApiUrl.quoteApi),
      headers: {
        'Authorization': 'Bearer ${preferences.getString(Keys.accessToken)}',
        'Content-Type': 'application/json',
        'isJmClient':
            (preferences.getBool(Keys.isJmClient) ?? false).toString(),
      },
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: homeQuoteModelFromJson(response.body),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: homeQuoteModelFromJson(response.body),
      );
    }
  }
}
