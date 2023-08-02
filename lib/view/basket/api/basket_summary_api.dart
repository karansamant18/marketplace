import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/view/basket/api/dummy_data.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_dashboard_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/invest_summary_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:http/http.dart' as http;

class BasketSummaryApi {
  Future<ResponseModel<InvestSummaryModel>> getInvestSummary() async {
    final response = await http.get(Uri.parse(ApiUrl.investSummaryApi),
        headers: {
          'x-api-key': Keys.eleverApiKey,
          'Authorization': Keys.eleverAuthToken
        });

    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: InvestSummaryModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: response.statusCode,
        data: null,
      );
    }
  }

  Future<ResponseModel<BasketDashboardModel>> getBasketDashboard(
      String status) async {
    final response = await http.get(Uri.parse(ApiUrl.basketDashboardApi),
        headers: {
          'x-api-key': Keys.eleverApiKey,
          'Authorization': Keys.eleverAuthToken
        });

    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: BasketDashboardModel.fromJson(getDummyData(status)),
      );
    } else {
      return ResponseModel(
        status: response.statusCode,
        data: null,
      );
    }
  }

  Map<String, dynamic> dummyDataMap = {
    "Due - Rebalance": dummyData.rebalanceData,
    "Due - SIP & Rebalance": dummyData.sipWithOutStandRiskData,
    "Due - SIP": dummyData.sipWithOutStandData,
    "Last Order failed": dummyData.rejectedData,
    "Approved": dummyData.approvedData,
    "Active": dummyData.activeData,
    "Pending Broken Order": dummyData.brokenOrderData,
    "Order Placed": dummyData.regularData,
  };

  getDummyData(String key) {
    return dummyDataMap[key];
  }
}
