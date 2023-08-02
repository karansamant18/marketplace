import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import '../const/keys.dart';

WebSocketChannel? socketAdvisory;
Stream<SocketDataModel> socketStream = socketSub.stream;
final StreamController<SocketDataModel> socketSub =
    StreamController<SocketDataModel>.broadcast();

Stream<bool> socketConnectStream = socketConnectSub.stream;
final StreamController<bool> socketConnectSub =
    StreamController<bool>.broadcast();

class CommonSocket extends ChangeNotifier {
  Timer? timer;

  // allows socket
  bool checkMarketStatus() {
    final now = DateTime.now();
    // debugPrint("${now.weekday < 6 && now.hour >= 9 && now.hour < 16}");
    if (now.weekday < 6 && now.hour >= 9 && now.hour < 16) {
      return true;
    }
    if (socketAdvisory != null) {
      disconnectWebsocket();
    }
    return false;
  }

  bool checkSocketToken() {
    return preferences.getString(Keys.marketDataToken) != null &&
        preferences.getString(Keys.marketDataToken) != "";
  }

  advisiorySocket(
      {String publishFormat = "JSON",
      String broadcastMode = "Full",
      String transport = "websocket",
      String EIO = "EIO"}) async {
    try {
      if (socketAdvisory == null &&
          UserAuth().isJmClient() &&
          UserAuth().isLoggedInBlinkX() &&
          checkSocketToken() &&
          checkMarketStatus()) {
        socketAdvisory = WebSocketChannel.connect(
          Uri.parse(
              'wss://smartweb.jmfinancialservices.in/apimarketdata/socket.io/?token=${preferences.getString(Keys.marketDataToken)}&userID=${preferences.getString(Keys.userPhoneNo)}_WEB&publishFormat=$publishFormat&broadcastMode=$broadcastMode&transport=$transport&EIO=$EIO'),
        );
        connectionMade();
        // sendPing();
        socketAdvisory!.stream.listen(
          (event) {
            debugPrint("event coming...");
            // debugPrint(event.toString());
            if (event.toString().contains("1512-json-full")) {
              // debugPrint(event);
              String data = event
                  .toString()
                  .replaceAll("\\", "")
                  .replaceAll('42["1512-json-full","', "")
                  .replaceAll('"]', "")
                  .trim();
              // debugPrint(data);
              SocketDataModel modelData =
                  SocketDataModel.fromJson(json.decode(data));
              socketSub.sink.add(modelData);
            }
          },
          onDone: () {
            if (socketAdvisory != null) {
              disconnectWebsocket();
              advisiorySocket();
              debugPrint('ws channel closed');
            }
          },
          onError: (error) {
            if (socketAdvisory != null) {
              disconnectWebsocket();
              advisiorySocket();
              debugPrint('ws error $error');
            }
          },
        );
        socketAdvisory!.ready.catchError((onError) {
          if (socketAdvisory != null) {
            // disconnectWebsocket();
            debugPrint("catch error");
          }
        }).onError((error, stackTrace) {
          if (socketAdvisory != null) {
            // disconnectWebsocket();
            debugPrint("on error $error $stackTrace");
          }
        }).whenComplete(() {
          debugPrint("when complete");
        });
      }
    } catch (e) {
      debugPrint('error during connecting web socket ::: $e');
    }
  }

  sendPing() {
    timer = null;
    timer = Timer.periodic(
      const Duration(seconds: 45),
      (Timer t) {
        if (socketAdvisory != null) {
          socketAdvisory!.sink.add("200");
        } else {
          timer!.cancel();
        }
        // socketSub.sink.add("ping");
      },
    );
  }

  Future<dynamic> subscribeAdvisiorySocket({required List bodyData}) async {
    var headers = {
      'Authorization': preferences.getString(Keys.marketDataToken)!,
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({"instruments": bodyData, "xtsMessageCode": 1512});
    var response = await http.post(
        Uri.parse(
            'https://smartweb.jmfinancialservices.in/apimarketdata/instruments/subscription'),
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<dynamic> unSubscribeAdvisiorySocket({required List bodyData}) async {
    var headers = {
      'Authorization': preferences.getString(Keys.marketDataToken)!,
      'Content-Type': 'application/json'
    };
    var body = jsonEncode({"instruments": bodyData, "xtsMessageCode": 1512});
    var response = await http.put(
        Uri.parse(
            'https://smartweb.jmfinancialservices.in/apimarketdata/instruments/subscription'),
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  subscribeTokens(List<AdvisoryResults> advisoryResults) {
    if (advisoryResults.isNotEmpty &&
        socketAdvisory != null &&
        checkMarketStatus()) {
      List inst = [];
      advisoryResults.forEach((ele) {
        inst.add({
          "exchangeSegment": ele.isCash == true ? 1 : 2,
          "exchangeInstrumentID": ele.secToken!,
        });
      });
      subscribeAdvisiorySocket(bodyData: inst);
    }
  }

  unsubscribeTokens(List<AdvisoryResults> advisoryResults) {
    if (advisoryResults.isNotEmpty &&
        socketAdvisory != null &&
        checkMarketStatus()) {
      List inst = [];
      advisoryResults.forEach((ele) {
        inst.add({
          "exchangeSegment": ele.isCash == true ? 1 : 2,
          "exchangeInstrumentID": ele.secToken!,
        });
      });
      unSubscribeAdvisiorySocket(bodyData: inst);
    }
  }

  connectionMade() {
    if (socketAdvisory != null) {
      socketConnectSub.sink.add(true);
    } else {
      socketConnectSub.sink.add(false);
    }
  }

  isSocketConnected() {
    return socketAdvisory;
  }

  disconnectWebsocket() {
    if (timer != null) {
      timer!.cancel();
    }
    if (socketAdvisory != null) {
      debugPrint("socket disconnecting...");
      socketAdvisory!.sink.close();
      socketAdvisory = null;
    }
  }

  // pauseSocket() {
  //   socketAdvisory!.ready.then((value) => null);
  // }
}

class SocketDataModel {
  int? messageCode;
  int? messageVersion;
  int? applicationType;
  int? tokenID;
  int? exchangeSegment;
  int? exchangeInstrumentID;
  int? bookType;
  int? xMarketType;
  double? lastTradedPrice;
  int? lastTradedQunatity;
  int? lastUpdateTime;
  double? percentChange;
  double? close;

  SocketDataModel(
      {this.messageCode,
      this.messageVersion,
      this.applicationType,
      this.tokenID,
      this.exchangeSegment,
      this.exchangeInstrumentID,
      this.bookType,
      this.xMarketType,
      this.lastTradedPrice,
      this.lastTradedQunatity,
      this.lastUpdateTime,
      this.percentChange,
      this.close});

  SocketDataModel.fromJson(Map<String, dynamic> json) {
    messageCode = json['MessageCode'];
    messageVersion = json['MessageVersion'];
    applicationType = json['ApplicationType'];
    tokenID = json['TokenID'];
    exchangeSegment = json['ExchangeSegment'];
    exchangeInstrumentID = json['ExchangeInstrumentID'];
    bookType = json['BookType'];
    xMarketType = json['XMarketType'];
    lastTradedPrice = json['LastTradedPrice'].toDouble();
    lastTradedQunatity = json['LastTradedQunatity'];
    lastUpdateTime = json['LastUpdateTime'];
    percentChange = double.parse(json['PercentChange'].toString());
    close = double.parse(json['Close'].toString());
  }
}
