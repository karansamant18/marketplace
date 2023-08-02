import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_bx/view/helper/api/helper_api.dart';
import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
import 'package:flutter_mobile_bx/view/portfolio/api/portfolio_api.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/holdings_model.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/portfolio_holdings_model.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/positions_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class PortfolioController extends ChangeNotifier {
  PortfolioApi portfolioApi = PortfolioApi();
  HelperApi helperApi = HelperApi();
  ResponseModel<HoldingsModel> holdingsModel = ResponseModel<HoldingsModel>();
  ResponseModel<PositionsModel> netPositionsModel =
      ResponseModel<PositionsModel>();
  ResponseModel<PortfolioHoldings> portfolioHoldingsModel =
      ResponseModel<PortfolioHoldings>();
  ResponseModel<PositionsModel> dayPositionsModel =
      ResponseModel<PositionsModel>();
  HomeController homeController = HomeController();
  // Get Holdings
  // Future<ResponseModel<HoldingsModel>> holdingsController() async {
  //   holdingsModel = await portfolioApi.holdingsApi();
  //   if (holdingsModel.data!.data!.isNotEmpty) {
  //     List inst = [];
  //     holdingsModel.data!.data!.forEach((element) {
  //       inst.add({
  //         "exchangeSegment": element.exchange == 'NSE' ? 1 : 11,
  //         "exchangeInstrumentID": int.parse(element.symboltoken!)
  //       });
  //     });
  //     HelperApi().instrumentQuotesApi(
  //       quotes: {
  //         "instruments": inst,
  //         "xtsMessageCode": 1502,
  //         "publishFormat": "JSON"
  //       },
  //     ).then((value) {
  //       holdingsModel.data!.data!.forEach((element) {
  //         final ind = value.data!.result!.listQuotes!.indexWhere((ele) =>
  //             ele.exchangeInstrumentID ==
  //             int.parse(element.symboltoken.toString()));
  //         element.ltp =
  //             value.data!.result!.listQuotes![ind].touchline!.lastTradedPrice;
  //       });
  //       notifyListeners();
  //     });
  //   }
  //   notifyListeners();
  //   return holdingsModel;
  // }

  // Get Net Positions
  Future<ResponseModel<PositionsModel>> netPositionsController() async {
    netPositionsModel = await portfolioApi.netPositionsApi();
    notifyListeners();
    return netPositionsModel;
  }

  // Get Day Positions
  Future<ResponseModel<PositionsModel>> dayPositionsController() async {
    dayPositionsModel = await portfolioApi.dayPositionsApi();
    notifyListeners();
    return dayPositionsModel;
  }

  // Get Holdings
  portfolioHoldingsController() async {
    portfolioHoldingsModel = await portfolioApi.portfolioHoldingsApi();
    if (portfolioHoldingsModel.data != null &&
        portfolioHoldingsModel.data!.data!.portfolio != null &&
        portfolioHoldingsModel
            .data!.data!.portfolio!.equityHoldings!.isNotEmpty) {
      List inst = [];
      portfolioHoldingsModel.data!.data!.portfolio!.equityHoldings!
          .forEach((element) {
        inst.add({
          "exchangeSegment": element.symbol!.exc == 'NSE'
              ? 1
              : (element.symbol!.exc == 'NFO' ? 2 : 11),
          "exchangeInstrumentID": int.parse(element.symbol!.streamSym!)
        });
      });
      helperApi.instrumentQuotesApi(
        quotes: {
          "instruments": inst,
          "xtsMessageCode": 1502,
          "publishFormat": "JSON"
        },
      ).then((value) {
        if (value.data != null) {
          portfolioHoldingsModel.data!.data!.portfolio!.equityHoldings!
              .forEach((element) {
            final ind = value.data!.result!.listQuotes!.indexWhere((ele) =>
                ele.exchangeInstrumentID ==
                int.parse(element.symbol!.streamSym.toString()));
            element.symbol!.ltp =
                value.data!.result!.listQuotes![ind].touchline!.lastTradedPrice;
            element.symbol!.pnl = (value.data!.result!.listQuotes![ind]
                        .touchline!.lastTradedPrice! *
                    element.netQty!) -
                (element.invested!);
            element.symbol!.pnlPct = (100 *
                ((value.data!.result!.listQuotes![ind].touchline!
                            .lastTradedPrice! *
                        element.netQty!) -
                    (element.invested!)) /
                (element.invested!));
          });
          notifyListeners();
        }
      });
    }
    notifyListeners();
  }
}
