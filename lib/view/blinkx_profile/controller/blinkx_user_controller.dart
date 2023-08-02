import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/blinkx_profile/api/blinkx_user_api.dart';
import 'package:flutter_mobile_bx/view/blinkx_profile/model/blinkx_profile_model.dart';
import 'package:rxdart/rxdart.dart';

class BlinkxUserController extends ChangeNotifier {
  BlinkxUserApi blinkxUserApi = BlinkxUserApi();

  PublishSubject<ResponseModel<BlinkxUserProfileModel>> userProfileController =
      PublishSubject<ResponseModel<BlinkxUserProfileModel>>();

  Stream<ResponseModel<BlinkxUserProfileModel>> get userProfileStream =>
      userProfileController.stream;

  //User Profile Sink
  Future<ResponseModel<BlinkxUserProfileModel>> userProfileSink() async {
    ResponseModel<BlinkxUserProfileModel> userRespnse =
        await blinkxUserApi.userProfileApi();
    preferences.setString(Keys.userId, userRespnse.data!.data!.id.toString());
    // userProfileController.sink.add(userRespnse);
    notifyListeners();
    return userRespnse;
  }
}
