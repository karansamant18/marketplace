import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/auth/api/auth_api.dart';
import 'package:flutter_mobile_bx/view/auth/model/send_otp_model.dart';
import 'package:flutter_mobile_bx/view/auth/model/update_name_model.dart';
import 'package:flutter_mobile_bx/view/auth/model/verify_otp_model.dart';

class AuthController {
  LoginApi loginApi = LoginApi();

  // Send OTP Controller
  Future<ResponseModel<SendOTPModel>> sendOtpController(
      {required String phoneNo}) async {
    ResponseModel<SendOTPModel> sendOTPMode =
        await loginApi.sendOtpApi(phoneNo: phoneNo);
    return sendOTPMode;
  }

  // Verify OTP Controller
  Future<ResponseModel<VerifyOTPModel>> verifyOtpController(
      {required String phoneNo, required String otp}) async {
    ResponseModel<VerifyOTPModel> verifyOTPModel =
        await loginApi.verifyOtpApi(phoneNo: phoneNo, otp: otp);
    return verifyOTPModel;
  }

  // Update First Name Controller
  Future<ResponseModel<UpdateNameModel>> updateFirstNameController(
      {required String userName}) async {
    ResponseModel<UpdateNameModel> updateFirstNameModel =
        await loginApi.updateFirstNameApi(userName: userName);
    return updateFirstNameModel;
  }
}
