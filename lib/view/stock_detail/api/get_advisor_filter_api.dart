import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class GetAdvisorFilterApi {
  //Get Advisor Call Api
  Future<ResponseModel<GetAdvisorCallsModel>> getAdvisorFilterApi({
    required List filters,
    String sortBy = "",
    String order = "",
  }) async {
    var headers = {
      'Authorization': 'Bearer ${preferences.getString(Keys.accessToken)}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(ApiUrl.advisorCallsApi));
    request.body = sortBy == ""
        ? json.encode({"count": 500, "page": 0, "filters": filters})
        : json.encode({
            "count": 500,
            "page": 0,
            "filters": filters,
            "sortBy": sortBy,
            "order": order
          });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return ResponseModel(
        status: 200,
        data: GetAdvisorCallsModel.fromJson(json.decode(responseData)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }
}
