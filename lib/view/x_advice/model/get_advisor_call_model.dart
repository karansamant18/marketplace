import 'dart:convert';

import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:intl/intl.dart';

GetAdvisorCallsModel getAdvisorCallsModel(String str) =>
    GetAdvisorCallsModel.fromJson(json.decode(str));

bool isLoggedinBlinkx = UserAuth().isLoggedInBlinkX();

class GetAdvisorCallsModel {
  List<AdvisoryResults>? advisoryResults;
  int? totalPages;
  int? totalCount;

  GetAdvisorCallsModel(
      {this.advisoryResults, this.totalPages, this.totalCount});

  GetAdvisorCallsModel.fromJson(Map<String, dynamic> json) {
    if (json['advisoryResults'] != null) {
      advisoryResults = <AdvisoryResults>[];
      json['advisoryResults'].forEach((v) {
        advisoryResults!.add(new AdvisoryResults.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    totalCount = json['totalCount'];
  }
}

class AdvisoryResults {
  int? id;
  String? advisor;
  int? advisorid;
  String? callcategory;
  String? callduration;
  String? symbol;
  String? callstatus;
  String? callexpiry;
  String? callsenttime;
  String? status;
  TokenData? tokenData;
  String? optiontype;
  String? messagetype;
  String? instrument;
  String? segment;
  double? strikeprice;
  double? closeprice;
  double? callpl;
  String? callmessage;
  double? partialexitprice;
  String? subsegment;
  String? contractexpiry;
  String? callresult;
  String? exchange;
  String? category;
  String? subcategory;
  String? isin;
  double? highprice;
  double? lowPrice;
  double? rrr;
  double? trgpc;
  double? slpc;
  double? manuallyClosed;
  int? secToken;
  String? expirydate;
  double? entryprice1;
  double? entryprice2;
  double? targetprice1;
  double? targetprice2;
  double? targetprice3;
  double? stopLossprice1;
  double? stopLossprice2;
  double? stopLossprice3;
  List<String>? attachmentfilelink;
  List<Internalremarks>? internalremarks;
  String? videolink;
  int? lotsize;
  double? potentialData;
  int? daysLeft;
  String? callPutText;
  String? symbolFormatted;
  String? callCategoryText;
  bool? isSelected = false;
  String? calltype = 'buy';
  bool? isCash = false;
  bool? isFut = false;
  bool? isOpt = false;
  double? ltp;

  AdvisoryResults({
    this.id,
    this.advisor,
    this.advisorid,
    this.callcategory,
    this.callduration,
    this.symbol,
    this.callstatus,
    this.callexpiry,
    this.callsenttime,
    this.status,
    this.tokenData,
    this.optiontype,
    this.messagetype,
    this.instrument,
    this.segment,
    this.strikeprice,
    this.closeprice,
    this.callpl,
    this.callmessage,
    this.partialexitprice,
    this.subsegment,
    this.contractexpiry,
    this.callresult,
    this.exchange,
    this.category,
    this.subcategory,
    this.isin,
    this.highprice,
    this.lowPrice,
    this.rrr,
    this.trgpc,
    this.slpc,
    this.manuallyClosed,
    this.secToken,
    this.expirydate,
    this.entryprice1,
    this.entryprice2,
    this.targetprice1,
    this.targetprice2,
    this.targetprice3,
    this.stopLossprice1,
    this.stopLossprice2,
    this.stopLossprice3,
    this.attachmentfilelink,
    this.internalremarks,
    this.videolink,
    this.lotsize,
    this.callCategoryText,
    this.callPutText,
    this.daysLeft,
    this.potentialData,
    this.symbolFormatted,
    this.isSelected,
    this.calltype,
    this.isCash,
    this.isFut,
    this.isOpt,
    this.ltp,
  });

  AdvisoryResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advisor = json['advisor'];
    advisorid = json['advisorid'];
    callcategory = json['callcategory'];
    callduration = json['callduration'];
    symbol = json['symbol'];
    callstatus = json['callstatus'];
    callexpiry = json['callexpiry'];
    callsenttime = json['callsenttime'];
    status = json['status'];
    tokenData = json['tokenData'] != null
        ? new TokenData.fromJson(json['tokenData'])
        : null;
    optiontype = json['optiontype'];
    messagetype = json['messagetype'];
    instrument = json['instrument'];
    segment = json['segment'];
    strikeprice = json['strikeprice'];
    closeprice = json['closeprice'];
    callpl = json['callpl'];
    calltype = json["calltype"];
    callmessage = json['callmessage'];
    partialexitprice = json['partialexitprice'];
    subsegment = json['subsegment'];
    contractexpiry = json['contractexpiry'];
    callresult = json['callresult'];
    exchange = json['exchange'];
    category = json['category'];
    subcategory = json['subcategory'];
    isin = json['isin'];
    highprice = json['highprice'];
    lowPrice = json['lowPrice'];
    rrr = json['rrr'];
    trgpc = json['trgpc'];
    slpc = json['slpc'];
    manuallyClosed = double.parse(json['manuallyClosed'].toString());
    secToken = json['secToken'];
    expirydate = json['expirydate'];
    entryprice1 = json['entryprice1'];
    entryprice2 = json['entryprice2'];
    targetprice1 = json['targetprice1'];
    targetprice2 = json['targetprice2'];
    targetprice3 = json['targetprice3'];
    stopLossprice1 = json['stopLossprice1'] == 0.0
        ? calltype == "buy"
            ? double.parse(
                (entryprice1! + entryprice1! * 0.4).toStringAsFixed(2))
            : double.parse(
                (entryprice1! - entryprice1! * 0.4).toStringAsFixed(2))
        : json['stopLossprice1'];
    stopLossprice2 = json['stopLossprice2'];
    stopLossprice3 = json['stopLossprice3'];
    isSelected = false;
    // ltp = tokenData!.ltpCmots ??
    //     (double.parse(((entryprice1! + targetprice1!) / 2).toStringAsFixed(2)));
    ltp = isLoggedinBlinkx == true
        ? (tokenData!.ltpSymphony ?? 0.0)
        : (tokenData!.ltpCmots ?? 0.0);
    if (json['attachmentfilelink'] != null) {
      attachmentfilelink = <String>[];
      json['attachmentfilelink'].forEach((v) {
        attachmentfilelink!.add(v.toString());
      });
    }
    if (json['internalremarks'] != null) {
      internalremarks = <Internalremarks>[];
      json['internalremarks'].forEach((v) {
        internalremarks!.add(Internalremarks.fromJson(v));
      });
    }
    videolink = json['videolink'] ?? "";

    isCash = subsegment == 'NSECASH' ? true : false;
    isFut = subsegment == 'NSEFUT' ? true : false;
    isOpt = (subsegment == "NSECALL" || subsegment == "NSEPUT") ? true : false;
    lotsize = (json['tokenData']['lotSize'] != 0.0 &&
            json['tokenData']['lotSize'] != null)
        ? int.parse(tokenData!.lotSize.toString().split('.')[0])
        : 1;
    potentialData = double.parse((calltype == 'buy'
            ? (ltp! < targetprice1!)
                ? (100 * (targetprice1! - ltp!) / ltp!)
                : 0.00
            : (ltp! > targetprice1!)
                ? 100 * (ltp! - targetprice1!) / ltp!
                : 0.00)
        .toStringAsFixed(2));
    // potentialData = ((strikeprice ?? 0.0) > (entryprice1 ?? 0.0))
    //     ? ((((targetprice1 ?? 0.0) - (strikeprice ?? 0.0)) /
    //             (strikeprice ?? 0.0)) *
    //         100)
    //     : ((((targetprice1 ?? 0.0) - (entryprice1 ?? 0.0)) /
    //             (entryprice1 ?? 0.0)) *
    //         100);
    daysLeft = calculateDaysLeft(DateTime.parse(callexpiry!).toString());
    callPutText = subsegment == "NSECALL" || subsegment == "NSEPUT"
        ? subsegment == "NSECALL"
            ? "Call"
            : "Put"
        : "";
    symbolFormatted = (subsegment == 'NSECASH'
        ? symbol
        : subsegment == 'NSEFUT'
            ? '$symbol Futures'
            : subsegment == "NSECALL"
                ? '$symbol $strikeprice CE'
                : '$symbol $strikeprice PE');
    callCategoryText = callcategory == "FUNDAMENTAL"
        ? 'Investor'
        : callcategory == "DERIVATIVE"
            ? "FnO Trader"
            : "Trader";
  }
}

int calculateDaysLeft(expiry) {
  DateTime currentDate = DateTime.now();
  DateTime? callexpiryDate;
  callexpiryDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(expiry ?? '');
  int days = callexpiryDate.difference(currentDate).inDays > 0
      ? callexpiryDate.difference(currentDate).inDays
      : 0;
  return days;
}

class TokenData {
  String? cmotsToken;
  String? symphonyToken;
  String? apigeeToken;
  double? ltpCmots;
  double? lotSize;
  double? ltpSymphony;

  TokenData(
      {this.cmotsToken, this.symphonyToken, this.apigeeToken, this.ltpCmots});

  TokenData.fromJson(Map<String, dynamic> json) {
    cmotsToken = json['cmotsToken'];
    symphonyToken = json['symphonyToken'];
    apigeeToken = json['apigeeToken'];
    ltpCmots = json['ltpCmots'];
    lotSize = json['lotSize'];
    ltpSymphony = json['ltpSymphony'];
  }
}

class Internalremarks {
  String? rType;
  String? message;
  String? senttime;

  Internalremarks({this.rType, this.message, this.senttime});

  Internalremarks.fromJson(Map<String, dynamic> json) {
    rType = json['rType'];
    message = json['message'];
    senttime = json['senttime'];
  }
}
