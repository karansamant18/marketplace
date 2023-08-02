import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/auth/model/send_otp_model.dart';
import 'package:flutter_mobile_bx/view/auth/model/update_name_model.dart';
import 'package:flutter_mobile_bx/view/auth/model/verify_otp_model.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  //Send OTP
  Future<ResponseModel<SendOTPModel>> sendOtpApi(
      {required String phoneNo}) async {
    final response =
        await http.post(Uri.parse("${ApiUrl.sendOTPUrl}/$phoneNo"));
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: SendOTPModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: SendOTPModel.fromJson(json.decode(response.body)),
      );
    }
  }

  //Verify OTP
  Future<ResponseModel<VerifyOTPModel>> verifyOtpApi(
      {required String phoneNo, required String otp}) async {
    var mapData = {
      "phoneNo": phoneNo,
      "otp": otp,
    };
    final response = await http.post(Uri.parse(ApiUrl.verifyOTPUrl),
        body: json.encode(mapData),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: VerifyOTPModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: VerifyOTPModel.fromJson(json.decode(response.body)),
      );
    }
  }

  //Updte First Name Api
  Future<ResponseModel<UpdateNameModel>> updateFirstNameApi(
      {required String userName}) async {
    final response = await http.put(
      Uri.parse("${ApiUrl.updateNameUrl}name=$userName"),
      headers: {'Authorization': preferences.getString(Keys.accessToken) ?? ''},
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: UpdateNameModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: UpdateNameModel.fromJson(json.decode(response.body)),
      );
    }
  }
}
