import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_bx/view/user_profile/model/is_jm_client_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/user_profile/api/user_profile_api.dart';
import 'package:flutter_mobile_bx/view/user_profile/model/user_profile_model.dart';

class UserProfileController extends ChangeNotifier {
  UserProfileApi userProfileApi = UserProfileApi();

  ResponseModel<IsJmClientModel> isJmClientModel =
      ResponseModel<IsJmClientModel>();
  ResponseModel<UserProfileModel> userProfileModel =
      ResponseModel<UserProfileModel>();
  // Get Order Book
  Future<ResponseModel<UserProfileModel>> jmUserProfileController() async {
    userProfileModel = await userProfileApi.jmUserProfileApi();
    notifyListeners();
    return userProfileModel;
  }

  // Get If user is jm client Controller
  Future<ResponseModel<IsJmClientModel>> getDetailspApiController(
      {required String phoneNo}) async {
    isJmClientModel = await userProfileApi.isJmClientApi(phoneNo: phoneNo);
    notifyListeners();
    return isJmClientModel;
  }
}
