import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_bx/view/basket/api/basket_api.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_intro_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_perf_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_proposal.dart';
import 'package:flutter_mobile_bx/view/basket/model/invest_basket_modal.dart';
import 'package:flutter_mobile_bx/view/basket/model/place_trade_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/post_trade_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

class BasketController extends ChangeNotifier {
  BasketApi basketApi = BasketApi();
  Basket? selectedBasket;
  ResponseModel<BasketIntroModel> basketIntroModel =
      ResponseModel<BasketIntroModel>();
  ResponseModel<BasketModel>? allBasket = ResponseModel<BasketModel>();
  ResponseModel<BasketPerfModel> basketPerfModel =
      ResponseModel<BasketPerfModel>();
  ResponseModel<BasketProposalModel> basketProposalModel =
      ResponseModel<BasketProposalModel>();
  ResponseModel<InvestInBasektModel> investInBasektModel =
      ResponseModel<InvestInBasektModel>();
  ResponseModel<PlaceTradeModel> placeTradeModel =
      ResponseModel<PlaceTradeModel>();
  ResponseModel<PostTradeModel> postTradeModel =
      ResponseModel<PostTradeModel>();

  updateSelectedBasket(Basket data) async {
    selectedBasket = data;
    notifyListeners();
  }

  // Get Basket Intro
  Future<ResponseModel<BasketIntroModel>> basketIntroController(
      {required String productId}) async {
    basketIntroModel = await basketApi.basketIntroApi(productId: productId);
    notifyListeners();
    return basketIntroModel;
  }

  // Get Basket Performance
  Future<ResponseModel<BasketPerfModel>> basketPerfController() async {
    basketPerfModel = await basketApi.basketPerfApi();
    notifyListeners();
    return basketPerfModel;
  }

  // Get Basket Proposal
  Future<ResponseModel<BasketProposalModel>> basketProposalController({
    required String productID,
    required double investAmt,
  }) async {
    basketProposalModel = await basketApi.basketProposalApi(
      productID: productID,
      investAmt: investAmt,
    );
    notifyListeners();
    return basketProposalModel;
  }

  // Invest Basket
  Future<ResponseModel<InvestInBasektModel>> investBasketController(
      {required Map<String, Object> object}) async {
    investInBasektModel = await basketApi.investBasketApi(object: object);
    notifyListeners();
    return investInBasektModel;
  }

  // Place Trade
  Future<ResponseModel<PlaceTradeModel>> placeTradeController(
      {required String orderID}) async {
    placeTradeModel = await basketApi.placeTradeApi(orderID: orderID);
    notifyListeners();
    return placeTradeModel;
  }

  // Get All Basket
  Future<ResponseModel<BasketModel>> getAllBasket() async {
    allBasket = await basketApi.getAllBasket();
    notifyListeners();
    return allBasket!;
  }

  // Get All Basket
  Future<ResponseModel<PostTradeModel>> eleverPostTradeBasket(
      {required Map<String, dynamic> object}) async {
    postTradeModel = await basketApi.eleverPostTradeApi(object: object);
    notifyListeners();
    return postTradeModel;
  }
}
