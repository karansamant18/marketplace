import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_bx/view/basket/api/basket_summary_api.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_dashboard_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/invest_summary_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class BasketSummaryController extends ChangeNotifier {
  BasketSummaryApi basketSummaryApi = BasketSummaryApi();
  ResponseModel<InvestSummaryModel> investSummaryModel =
      ResponseModel<InvestSummaryModel>();
  ResponseModel<BasketDashboardModel> basketDashboardModel =
      ResponseModel<BasketDashboardModel>();

  // Get Invest Summary
  Future<ResponseModel<InvestSummaryModel>> investSummary() async {
    investSummaryModel = await basketSummaryApi.getInvestSummary();
    notifyListeners();
    return investSummaryModel;
  }

  // Get Basket Dashboard
  Future<ResponseModel<BasketDashboardModel>> getBasketDashboard(
      String status) async {
    basketDashboardModel = await basketSummaryApi.getBasketDashboard(status);
    notifyListeners();
    return basketDashboardModel;
  }
}
