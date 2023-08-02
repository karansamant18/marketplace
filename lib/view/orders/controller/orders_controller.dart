import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_bx/view/helper/api/helper_api.dart';
import 'package:flutter_mobile_bx/view/orders/api/orders_api.dart';
import 'package:flutter_mobile_bx/view/orders/model/orders_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class OrderController extends ChangeNotifier {
  OrdersApi ordersApi = OrdersApi();
  ResponseModel<OrderModel> orderModel = ResponseModel<OrderModel>();
  ResponseModel<bool> cancelOrderStatus = ResponseModel<bool>();

  // Get Order Book
  Future<ResponseModel<OrderModel>> orderBookController() async {
    orderModel = await ordersApi.orderBookApi();
    List inst = [];
    orderModel.data!.data.forEach((element) {
      inst.add({
        "exchangeSegment": element.exchange == 'NSE'
            ? 1
            : (element.exchange == 'NFO' ? 2 : 11),
        "exchangeInstrumentID": int.parse(element.symboltoken!)
      });
    });
    HelperApi().instrumentQuotesApi(
      quotes: {
        "instruments": inst,
        "xtsMessageCode": 1502,
        "publishFormat": "JSON"
      },
    ).then((value) {
      orderModel.data!.data.forEach((element) {
        final ind = value.data!.result!.listQuotes!.indexWhere((ele) =>
            ele.exchangeInstrumentID ==
            int.parse(element.symboltoken.toString()));
        element.ltp =
            value.data!.result!.listQuotes![ind].touchline!.lastTradedPrice;
      });
      notifyListeners();
    });
    notifyListeners();
    return orderModel;
  }

  // Get Order Book
  Future<ResponseModel<bool>> cancelOrderController(
      {required String orderId}) async {
    cancelOrderStatus = await ordersApi.cancelOrderApi(orderId: orderId);
    notifyListeners();
    return cancelOrderStatus;
  }
}
