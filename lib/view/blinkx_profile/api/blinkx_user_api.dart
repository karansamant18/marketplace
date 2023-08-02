import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/view/blinkx_profile/model/blinkx_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class BlinkxUserApi {
  // user Profile blinkx
  Future<ResponseModel<BlinkxUserProfileModel>> userProfileApi() async {
    final response = await http.get(
      Uri.parse(ApiUrl.userProfile),
      headers: {'Authorization': preferences.getString(Keys.accessToken) ?? ''},
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: BlinkxUserProfileModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  // Update user Profile blinkx
  updateUserProfileApi(Map<String, dynamic> data) async {
    final response = await http.put(Uri.parse(ApiUrl.userProfile),
        headers: {
          'Authorization': preferences.getString(Keys.accessToken) ?? '',
          'Content-Type': 'application/json'
        },
        body: json.encode(data));
    if (response.statusCode == 200) {
      preferences.setString(Keys.userName, data["firstName"]);
      return true;
    } else {
      return false;
    }
  }
}
