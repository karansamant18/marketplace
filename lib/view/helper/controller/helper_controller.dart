import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/view/helper/api/helper_api.dart';
import 'package:flutter_mobile_bx/view/helper/model/instrument_quote_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

// OrderPlaceController orderPlaceController =
//         Provider.of<OrderPlaceController>(context, listen: false);

class HelperController extends ChangeNotifier {
  HelperApi helperApi = HelperApi();

  ResponseModel<InstrumentsQuoteModel> instrumentsQuoteModel =
      ResponseModel<InstrumentsQuoteModel>();

  AdvisoryResults? advisoryResults;

  // Order Data
  Future<ResponseModel<InstrumentsQuoteModel>> instrumentQuotesApi(
      {required dynamic quotes}) async {
    instrumentsQuoteModel = await helperApi.instrumentQuotesApi(quotes: quotes);
    notifyListeners();
    return instrumentsQuoteModel;
  }
}
