import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/view/home/api_provider/home_api_provider.dart';
import 'package:flutter_mobile_bx/view/home/model/client_config_model.dart';
import 'package:flutter_mobile_bx/view/home/model/home_quote_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';

Stream<bool> tokenSetStream = tokenSetSub.stream;
final StreamController<bool> tokenSetSub = StreamController<bool>.broadcast();

class HomeController extends ChangeNotifier {
  HomeApiProvider homeApiProvider = HomeApiProvider();
  bool fromExplore = false;
  int bottomSelectedIndex = 0;
  ResponseModel<List<HomeQuoteModel>> homeQuoteModel =
      ResponseModel<List<HomeQuoteModel>>();
  ResponseModel<ClientConfigModel> clientConfigModel =
      ResponseModel<ClientConfigModel>();

  // Get Advisor List Controller
  Future<ResponseModel<List<HomeQuoteModel>>> getQuoteController() async {
    homeQuoteModel = await homeApiProvider.getQuoteApi();
    notifyListeners();
    return homeQuoteModel;
  }

  updateFromExplore(bool value) {
    fromExplore = value;
    notifyListeners();
  }

  updateBottomSelectedIndex(int value) {
    bottomSelectedIndex = value;
    notifyListeners();
  }

  // // Get Client Config For Market Data
  // Future<ResponseModel<ClientConfigModel>> generateTokenClientConfig() async {
  //   clientConfigModel = await homeApiProvider.generateTokenClientConfig();
  //   notifyListeners();
  //   return clientConfigModel;
  // }

  // Future<bool> generateAccessToken() async {
  //   final status = await homeApiProvider.generateAccessToken();
  //   notifyListeners();
  //   return status;
  // }

  Future<bool> generateAccessTokenInitial() async {
    if (preferences.getString(Keys.marketDataToken) != null &&
        preferences.getString(Keys.marketDataToken) != "") {
      notifyListeners();
      return true;
    } else {
      final status = await homeApiProvider.generateAccessTokenInitial();
      final statusToken = await homeApiProvider.generateAccessToken();
      tokenSet();
      notifyListeners();
      return statusToken;
    }
  }

  tokenSet() {
    if (preferences.getString(Keys.marketDataToken) != null &&
        preferences.getString(Keys.marketDataToken) != "") {
      tokenSetSub.sink.add(true);
    } else {
      tokenSetSub.sink.add(false);
    }
  }
}
