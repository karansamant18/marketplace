import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/splash/spash_screen.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';

import '../const/keys.dart';
import '../const/url.dart';
import 'package:http/http.dart' as http;

import '../view/blinkx_login/blinkx_login.dart';
import '../view/buy_stock/buy_stock_screen.dart';
import '../view/helper/api/helper_api.dart';
import '../widgets/bottom_modal.dart';
import 'navigation_context.dart';

class UserAuth {
  Timer? refreshTokenTimer;

  bool isLoggedIn() {
    String? token = preferences.getString(Keys.accessToken);
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  bool isLoggedInBlinkX() {
    String? token = preferences.getString(Keys.accessTokenBlinkx);
    // String? token = null;
    if (token == null || token == "") {
      return false;
    } else {
      return true;
    }
  }

  bool isJmClient() {
    bool? isJmClient = preferences.getBool(Keys.isJmClient);
    // return true;
    return isJmClient ?? false;
  }

  showLoginBlinkX(
      {Widget afterLoginPage = const BuyStockScreen(), bool gaurd = false}) {
    // bool status = false;
    bool status = UserAuth().isLoggedInBlinkX();
    if (!status) {
      CommonDialogs.bottomDialog(
          WillPopScope(
              onWillPop: () async {
                if (gaurd) {
                  Navigator.pop(Navigation().context);
                  Navigator.pop(Navigation().context);
                  return false;
                } else {
                  return true;
                }
              },
              child: BlinkxLogin(
                nextPage: afterLoginPage,
              )),
          height: UserAuth().isJmClient() ? hh() / 1.9 : hh() / 1.5,
          dismissable: !gaurd);
    }
  }

  Future<void> updateAccessToken({required String accessToken}) async {
    bool newval = await preferences.setString(Keys.accessToken, accessToken);
    debugPrint("${newval}");
  }

  Future<void> updateRefreshToken({required String refreshToken}) async {
    await preferences.setString(Keys.refreshToken, refreshToken);
  }

  String? getRefreshToken() {
    return preferences.getString(Keys.refreshToken);
  }

  String? getAccessToken() {
    return preferences.getString(Keys.accessToken);
  }

  Future<void> updateAccessTokenBlinx({required String accessToken}) async {
    // bool newval =
    await preferences.setString(Keys.accessTokenBlinkx, accessToken);
    // debugPrint("$newval");
    // String? val =
    preferences.getString(Keys.accessTokenBlinkx);
    // debugPrint(val);
  }

  Future<void> updateRefreshTokenBlinx({required String refreshToken}) async {
    await preferences.setString(Keys.refreshTokenBlinkx, refreshToken);
  }

  Future<void> updateUserIdBlinx({required String userIdBlinkx}) async {
    await preferences.setString(Keys.userIdBlinkx, userIdBlinkx);
  }

  Future<void> setObjectToPref(
      {required String key, required dynamic object}) async {
    await preferences.setString(key, object.toString());
  }

  String? getObjectFromPref({required String key}) {
    return preferences.getString(key);
  }

  String? getRefreshTokenBlinx() {
    return preferences.getString(Keys.refreshTokenBlinkx);
  }

  String? getAccessTokenBlinx() {
    return preferences.getString(Keys.accessTokenBlinkx);
  }

  //Send OTP
  // Future<bool> loginMyconnect({required Map<String, String> body}) async {
  //   final response = await http
  //       .post(Uri.parse(ApiUrl.blinkXLogin), body: json.encode(body), headers: {
  //     'Content-Type': 'application/json',
  //     'apikey': 'E9ROIfZOlJXKm4ZGUl9xJDHGCEjgNQDa',
  //   });
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     await updateAccessTokenBlinx(accessToken: data["data"]["jwtToken"]);
  //     await updateRefreshTokenBlinx(refreshToken: data["data"]["refreshToken"]);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  //Send OTP
  Future<bool> loginBlinkX({required Map<String, String> body}) async {
    final response = await http
        .post(Uri.parse(ApiUrl.blinkXLogin), body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'apikey': Keys.apiKey,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      await updateAccessTokenBlinx(accessToken: data["data"]["jwtToken"]);
      await updateRefreshTokenBlinx(refreshToken: data["data"]["refreshToken"]);
      await updateUserIdBlinx(userIdBlinkx: body["LoginId"]!);

      if (isJmClient()) {
        await HelperApi.generateAdvisoryToken();
      }
      return true;
    } else {
      return false;
    }
  }

  Future refreshAccessTokenBlinkX() async {
    String? refreshToken = getRefreshTokenBlinx();
    String? accessToken = getAccessTokenBlinx();
    String? userId = preferences.getString(Keys.userIdBlinkx);
    // debugPrint(accessToken);
    if (refreshToken != null || refreshToken!.isNotEmpty) {
      try {
        var body = {
          "userId": userId,
          "devId": "",
          "refreshToken": refreshToken,
          "deviceId": "123123123",
          "deviceType": "Android",
          "accessToken": accessToken
        };
        final response = await http.post(Uri.parse(ApiUrl.refreshTokenUrl),
            body: json.encode(body),
            headers: {
              'Content-Type': 'application/json',
              'apikey': Keys.apiKey,
            });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          debugPrint("Token refresh successful");
          await updateAccessTokenBlinx(accessToken: data["data"]["jwtToken"]);
        } else {
          debugPrint("Token Unable to refresh");
          // debugPrint(response.body.toString());
          await updateAccessTokenBlinx(accessToken: "");
        }
      } catch (e) {
        await updateAccessTokenBlinx(accessToken: "");
        debugPrint("Error user_auth.dart $e");
      }
    }
  }

  get firstName {
    String? name = preferences.getString(Keys.userName);

    if (name != null) {
      // final nameList = name.split(" ");
      return name;
    } else {
      return null;
    }
  }

  static allLogout() async {
    await preferences.clear();
    CommonSocket().disconnectWebsocket();
    UserAuth().clearRefreshTokenTimer();
    Navigator.pushAndRemoveUntil(Navigation().context,
        MaterialPageRoute(builder: (context) {
      return SplashScreen();
    }), (Route<dynamic> route) => route is SplashScreen);
  }

  Future refreshAccessToken() async {
    String? refreshToken = getRefreshToken();
    String? accessToken = getAccessToken();
    debugPrint(accessToken);
    if (refreshToken != null) {
      try {
        var body = {
          "userId": "DBG048",
          "devId": "",
          "refreshToken": refreshToken,
          "deviceId": "123123123",
          "deviceType": "Android",
          "accessToken": accessToken
        };
        final response = await http.post(Uri.parse("${ApiUrl.refreshTokenUrl}"),
            body: json.encode(body),
            headers: {'Content-Type': 'application/json'});

        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          await updateAccessToken(accessToken: data["data"]["jwtToken"]);
        } else {
          await updateAccessToken(accessToken: "");
        }
      } catch (e) {
        await updateAccessToken(accessToken: "");
        debugPrint("Error user_auth.dart $e");
      }
    }
  }

  initiateRefreshToken() async {
    clearRefreshTokenTimer();
    var period = const Duration(minutes: 14, seconds: 50);
    bool loggedIn = isLoggedInBlinkX(); // jm Login
    if (loggedIn) {
      await refreshAccessTokenBlinkX();
    }
    refreshTokenTimer = Timer.periodic(period, (arg) async {
      bool loggedIn = isLoggedInBlinkX();
      if (loggedIn) {
        await refreshAccessTokenBlinkX();
      }
    });
  }

  clearRefreshTokenTimer() {
    if (refreshTokenTimer != null) {
      refreshTokenTimer!.cancel();
    }
  }
}
