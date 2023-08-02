import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/api/advisor_api.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/follow_advisor_list_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_model.dart';

class AdvisorController extends ChangeNotifier {
  //Api Instant
  AdvisorApi advisorApi = AdvisorApi();

  //Model
  ResponseModel<List<GetAdvisorListModel>> getAdvisorListModel =
      ResponseModel<List<GetAdvisorListModel>>();
  ResponseModel<GetAdvisorListModel> getAdvisorByIdModel =
      ResponseModel<GetAdvisorListModel>();
  ResponseModel<GetAdvisorCallsModel> advisorCallListModel =
      ResponseModel<GetAdvisorCallsModel>();
  ResponseModel<List<FollowAdvisorList>> followAdvisorList =
      ResponseModel<List<FollowAdvisorList>>();

  // Get Advisor List Controller
  Future<ResponseModel<List<GetAdvisorListModel>>>
      getAdvisorListController() async {
    getAdvisorListModel = await advisorApi.getAdvisorListApi();
    notifyListeners();
    return getAdvisorListModel;
  }

  // Get Advisor Calls List Controller
  Future<ResponseModel<GetAdvisorCallsModel>> advisorCallsListController(
      {required List filters, int count = 500, int page = 0}) async {
    advisorCallListModel = await advisorApi.getAdvisorCallApi(
        filters: filters, count: count, page: page);

    // if (UserAuth().isJmClient() && UserAuth().isLoggedInBlinkX()) {

    // List inst = [];
    // advisorCallListModel.data!.advisoryResults!.forEach((element) {
    //   inst.add({
    //     "exchangeSegment": element.isCash == true ? 1 : 2,
    //     "exchangeInstrumentID": element.secToken!,
    //   });
    // });
    // CommonSocket().subscribeAdvisiorySocket(bodyData: inst);

    // CommonSocket().socketStream.listen(
    //   (event) {
    //     advisorCallListModel.data!.advisoryResults!.forEach((element) {
    //       if (element.secToken == event.exchangeInstrumentID) {
    //         element.ltp = event.lastTradedPrice;
    //         notifyListeners();
    //       }
    //     });
    //   },
    // );
    //   HelperApi().instrumentQuotesApi(
    //     quotes: {
    //       "instruments": inst,
    //       "xtsMessageCode": 1502,
    //       "publishFormat": "JSON"
    //     },
    //   ).then((value) {
    //     advisorCallListModel.data!.advisoryResults!.forEach((element) {
    //       final ind = value.data!.result!.listQuotes!.indexWhere((ele) =>
    //           ele.exchangeInstrumentID ==
    //           int.parse(element.secToken.toString()));
    //       final ltp =
    //           value.data!.result!.listQuotes![ind].touchline!.lastTradedPrice!;
    //       if ((ltp != null && ltp >= 0)) {
    //         element.ltp = ltp;
    //       }
    //     });
    //     notifyListeners();
    //   });
    // }
    notifyListeners();
    return advisorCallListModel;
  }

  // Get Advisor By Id Controller
  Future<ResponseModel<GetAdvisorListModel>> getAdvisorByIdController(
      {required String id}) async {
    getAdvisorByIdModel = await advisorApi.getAdvisorByIdApi(id: id);
    notifyListeners();
    return getAdvisorByIdModel;
  }

  // Follow Advisor Controller
  Future<ResponseModel<FollowAdvisorList>> followAdvisorController(
      {required dynamic body}) async {
    final status = await advisorApi.followAdvisorApi(body: body);
    notifyListeners();
    return status;
  }

  // Get Follow Advisor Controller
  Future<ResponseModel<List<FollowAdvisorList>>>
      getFollowAdvisorController() async {
    followAdvisorList = await advisorApi.getFollowAdvisorController();
    notifyListeners();
    return followAdvisorList;
  }
}
