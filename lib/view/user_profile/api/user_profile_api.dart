import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/user_profile/model/is_jm_client_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/user_profile/model/user_profile_model.dart';
import 'package:http/http.dart' as http;

class UserProfileApi {
  // Get JM Client User Profile
  Future<ResponseModel<UserProfileModel>> jmUserProfileApi() async {
    String token = UserAuth().getAccessTokenBlinx() ?? "";
    final response =
        await http.post(Uri.parse(ApiUrl.userProfileApi), headers: {
      'apikey': Keys.apiKey,
      'Authorization': token,
    });

    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: UserProfileModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 401,
        data: null,
      );
    }
  }

  // Check if user is JM Client or Not
  Future<ResponseModel<IsJmClientModel>> isJmClientApi(
      {required String phoneNo}) async {
    var mapData = {
      "Phone": "+91-$phoneNo",
      // "Phone": "+91-8790928122",
    };
    final response = await http.post(Uri.parse(ApiUrl.getDetailsApi),
        body: json.encode(mapData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey("Details")) {
        preferences.setBool(Keys.isJmClient, true);
        final res = IsJmClientModel.fromJson(responseData);
        preferences.setString(Keys.userIdBlinkx, res.data!.clientId.toString());
        return ResponseModel(
          status: 200,
          data: res,
        );
      } else {
        preferences.setBool(Keys.isJmClient, false);
        return ResponseModel(
          status: 400,
          data: null,
        );
      }
    } else {
      return ResponseModel(
        status: 401,
        data: null,
      );
    }
  }
}
