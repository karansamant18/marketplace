import 'dart:convert';

import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/follow_advisor_list_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_model.dart';
import 'package:http/http.dart' as http;

class AdvisorApi {
  //Get Advisor Call Api
  Future<ResponseModel<GetAdvisorCallsModel>> getAdvisorCallApi(
      {required List filters, int count = 500, int page = 0}) async {
    var headers = {
      'Authorization': 'Bearer ${preferences.getString(Keys.accessToken)}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(ApiUrl.advisorCallsApi));
    request.body =
        json.encode({"count": count, "page": page, "filters": filters});
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

  //Get Advisor List
  Future<ResponseModel<List<GetAdvisorListModel>>> getAdvisorListApi() async {
    final response = await http.get(
      Uri.parse(ApiUrl.advisorListApi),
      headers: {
        'Authorization': 'Bearer ${preferences.getString(Keys.accessToken)}'
      },
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: getAdvisorModelFromJson(response.body),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: getAdvisorModelFromJson(response.body),
      );
    }
  }

  //Get Advisor By ID
  Future<ResponseModel<GetAdvisorListModel>> getAdvisorByIdApi({
    required String id,
  }) async {
    final response = await http.get(
      Uri.parse(ApiUrl.advisorByIdApi + id),
      headers: {
        'Authorization': 'Bearer ${preferences.getString(Keys.accessToken)}'
      },
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: GetAdvisorListModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: GetAdvisorListModel.fromJson(json.decode(response.body)),
      );
    }
  }

  //Get Advisor By ID
  Future<ResponseModel<List<FollowAdvisorList>>>
      getFollowAdvisorController() async {
    final response = await http.get(
      Uri.parse(
          "${ApiUrl.followAdvisorApi}/${preferences.getString(Keys.userId)}"),
      headers: {
        'Authorization': 'Bearer ${preferences.getString(Keys.accessToken)}'
      },
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: getFollowAdvisorList(response.body),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: getFollowAdvisorList(response.body),
      );
    }
  }

  //Follow Advisor By ID
  Future<ResponseModel<FollowAdvisorList>> followAdvisorApi({
    required dynamic body,
  }) async {
    final response = await http.post(
      Uri.parse(ApiUrl.followAdvisorApi),
      headers: {
        'Authorization': 'Bearer ${preferences.getString(Keys.accessToken)}',
        'Content-Type': 'application/json'
      },
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: FollowAdvisorList.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }
}
