import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/stock_detail/api/get_advisor_filter_api.dart';

class GetAdvisorFilterController extends ChangeNotifier {
  GetAdvisorFilterApi getAdvisorFilterApi = GetAdvisorFilterApi();

  ResponseModel<GetAdvisorCallsModel> getAdvisorCallModel =
      ResponseModel<GetAdvisorCallsModel>();

  // Get Advisor Call Book
  Future<ResponseModel<GetAdvisorCallsModel>> getAdvisorCallController(
      {required List filters, String sortBy = "", String order = ""}) async {
    getAdvisorCallModel = await getAdvisorFilterApi.getAdvisorFilterApi(
        filters: filters, sortBy: sortBy, order: order);
    notifyListeners();
    return getAdvisorCallModel;
  }
}
