class ClientConfigModel {
  String? type;
  String? code;
  String? description;
  Result? result;

  ClientConfigModel({this.type, this.code, this.description, this.result});

  ClientConfigModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    description = json['description'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }
}

class Result {
  Map<String, int>? exchangeSegments;
  XtsMessageCode? xtsMessageCode;
  List<String>? publishFormat;
  List<String>? broadCastMode;
  InstrumentType? instrumentType;

  Result(
      {this.exchangeSegments,
      this.xtsMessageCode,
      this.publishFormat,
      this.broadCastMode,
      this.instrumentType});

  Result.fromJson(Map<String, dynamic> json) {
    exchangeSegments = json['exchangeSegments'] != null
        ? Map<String, int>.from(json['exchangeSegments'])
        : null;
    xtsMessageCode = json['xtsMessageCode'] != null
        ? new XtsMessageCode.fromJson(json['xtsMessageCode'])
        : null;
    publishFormat = json['publishFormat'].cast<String>();
    broadCastMode = json['broadCastMode'].cast<String>();
    instrumentType = json['instrumentType'] != null
        ? new InstrumentType.fromJson(json['instrumentType'])
        : null;
  }
}

// class ExchangeSegments {
//   int? nSECM;
//   int? nSEFO;
//   int? nSECD;
//   int? nSECO;
//   int? sLBM;
//   int? nIFSC;
//   int? bSECM;
//   int? bSEFO;
//   int? bSECD;
//   int? bSECO;
//   int? nCDEX;
//   int? mSECM;
//   int? mSEFO;
//   int? mSECD;
//   int? mCXFO;

//   ExchangeSegments(
//       {this.nSECM,
//       this.nSEFO,
//       this.nSECD,
//       this.nSECO,
//       this.sLBM,
//       this.nIFSC,
//       this.bSECM,
//       this.bSEFO,
//       this.bSECD,
//       this.bSECO,
//       this.nCDEX,
//       this.mSECM,
//       this.mSEFO,
//       this.mSECD,
//       this.mCXFO});

//   ExchangeSegments.fromJson(Map<String, dynamic> json) {
//     nSECM = json['NSECM'];
//     nSEFO = json['NSEFO'];
//     nSECD = json['NSECD'];
//     nSECO = json['NSECO'];
//     sLBM = json['SLBM'];
//     nIFSC = json['NIFSC'];
//     bSECM = json['BSECM'];
//     bSEFO = json['BSEFO'];
//     bSECD = json['BSECD'];
//     bSECO = json['BSECO'];
//     nCDEX = json['NCDEX'];
//     mSECM = json['MSECM'];
//     mSEFO = json['MSEFO'];
//     mSECD = json['MSECD'];
//     mCXFO = json['MCXFO'];
//   }
// }

class XtsMessageCode {
  int? touchlineEvent;
  int? marketDepthEvent;
  int? indexDataEvent;
  int? candleDataEvent;
  int? openInterestEvent;
  int? instrumentPropertyChangeEvent;
  int? ltpEvent;

  XtsMessageCode(
      {this.touchlineEvent,
      this.marketDepthEvent,
      this.indexDataEvent,
      this.candleDataEvent,
      this.openInterestEvent,
      this.instrumentPropertyChangeEvent,
      this.ltpEvent});

  XtsMessageCode.fromJson(Map<String, dynamic> json) {
    touchlineEvent = json['touchlineEvent'];
    marketDepthEvent = json['marketDepthEvent'];
    indexDataEvent = json['indexDataEvent'];
    candleDataEvent = json['candleDataEvent'];
    openInterestEvent = json['openInterestEvent'];
    instrumentPropertyChangeEvent = json['instrumentPropertyChangeEvent'];
    ltpEvent = json['ltpEvent'];
  }
}

class InstrumentType {
  String? s1;
  String? s2;
  String? s4;
  String? s8;
  String? s16;
  String? s32;
  String? s64;
  String? s128;
  String? s256;
  String? s512;
  int? futures;
  int? options;
  int? spread;
  int? equity;
  int? spot;
  int? preferenceShares;
  int? debentures;
  int? warrants;
  int? miscellaneous;
  int? mutualFund;

  InstrumentType(
      {this.s1,
      this.s2,
      this.s4,
      this.s8,
      this.s16,
      this.s32,
      this.s64,
      this.s128,
      this.s256,
      this.s512,
      this.futures,
      this.options,
      this.spread,
      this.equity,
      this.spot,
      this.preferenceShares,
      this.debentures,
      this.warrants,
      this.miscellaneous,
      this.mutualFund});

  InstrumentType.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s4 = json['4'];
    s8 = json['8'];
    s16 = json['16'];
    s32 = json['32'];
    s64 = json['64'];
    s128 = json['128'];
    s256 = json['256'];
    s512 = json['512'];
    futures = json['Futures'];
    options = json['Options'];
    spread = json['Spread'];
    equity = json['Equity'];
    spot = json['Spot'];
    preferenceShares = json['PreferenceShares'];
    debentures = json['Debentures'];
    warrants = json['Warrants'];
    miscellaneous = json['Miscellaneous'];
    mutualFund = json['MutualFund'];
  }
}
