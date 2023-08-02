import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/view/buy_stock/api/place_order_api.dart';
import 'package:flutter_mobile_bx/view/buy_stock/model/order_limit_model.dart';
import 'package:flutter_mobile_bx/view/buy_stock/model/place_order_model.dart';
import 'package:flutter_mobile_bx/view/buy_stock/model/req_margin_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

// OrderPlaceController orderPlaceController =
//         Provider.of<OrderPlaceController>(context, listen: false);

class OrderPlaceController extends ChangeNotifier {
  PlaceOrderApi placeOrderApi = PlaceOrderApi();

  ResponseModel<PlaceOrderModel> placeOrderModel =
      ResponseModel<PlaceOrderModel>();
  ResponseModel<OrderLimitsModel> orderLimitsModel =
      ResponseModel<OrderLimitsModel>();
  ResponseModel<ReqMarginModel> reqMarginModel =
      ResponseModel<ReqMarginModel>();

  AdvisoryResults? advisoryResults;

  // Order Data
  Future<ResponseModel<PlaceOrderModel>> placeOrderController(
      {required Map<String, dynamic> orderData}) async {
    placeOrderModel = await placeOrderApi.placeOrderApi(orderData: orderData);
    notifyListeners();
    return placeOrderModel;
  }

  // Get Order Limits
  Future<ResponseModel<OrderLimitsModel>> orderLimitsController(
      Map<String, String> object) async {
    orderLimitsModel = await placeOrderApi.orderLimitsApi(object);
    notifyListeners();
    return orderLimitsModel;
  }

  // Req Margin
  Future<ResponseModel<ReqMarginModel>> reqMarginController(
      Map<String, dynamic> object) async {
    reqMarginModel = await placeOrderApi.reqMarginApi(object);
    notifyListeners();
    return reqMarginModel;
  }
}
