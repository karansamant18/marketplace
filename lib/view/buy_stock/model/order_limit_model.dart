class OrderLimitsModel {
  bool? status;
  String? message;
  String? errorcode;
  Null emsg;
  Data? data;

  OrderLimitsModel(
      {this.status, this.message, this.errorcode, this.emsg, this.data});

  OrderLimitsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
    emsg = json['emsg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }
}

class Data {
  String? sourceOfLimit;
  String? utilizationOfLimit;
  double? availableMargin;
  double? marginUsed;
  String? marginUsedPercentage;
  double? availableDerivativeMarginLimit;
  double? availableMarginLimit;
  double? availableDeliveryMarginLimitCNC;
  double? availableOptnBuyLimit;
  double? shortFall;
  String? cncrealizedmtomprsnt;
  String? deliverymarginprsnt;
  String? adhocscripmargin;
  String? brokerageprsnt;
  String? iPOAmount;
  String? bOmarginRequired;
  String? cdsspreadbenefit;
  String? scripbasketmargin;
  String? segment;
  Null equity;
  String? buyExposurePrsnt;
  String? grossCollateral;
  String? utilizedamount;
  String? branchadhoc;
  String? premiumpresent;
  Null mTM;
  String? sellExposurePrsnt;
  String? multiplier;
  String? elm;
  String? additionalpreexpirymarginprsnt;
  String? cOMarginRequired;
  String? nfospreadbenefit;
  String? valueindelivery;
  String? payoutAmt;
  String? losslimit;
  String? viewunrealizedmtom;
  String? cncmarginused;
  String? stockValuation;
  String? cncsellcreditpresent;
  String? mfssamountused;
  String? spanmargin;
  String? openingBalance;
  String? netcashavailable;
  String? bookedPNL;
  String? exposuremargin;
  String? unrealisedmtom;
  String? payinAmt;
  String? lien;
  String? viewrealizedmtom;
  String? unbookedPNL;
  String? cncMarginVarPrsnt;
  String? marginScripBasketCustomPresent;
  String? t1grossCollateral;
  String? adhoc;
  String? turnover;
  String? cncMarginElmPrsnt;
  String? grossexposurevalue;
  String? stat;
  String? buyPower;
  String? varmargin;
  String? mfamount;
  String? specialmarginprsnt;
  String? elbamount;
  String? directcollateralvalue;
  String? additionalmarginprsnt;
  String? realisedmtom;
  String? tendermarginprsnt;
  String? cncunrealizedmtomprsnt;
  String? financelimit;
  String? adhocmargin;
  String? category;
  String? cncbrokerageprsnt;
  String? notionalcash;

  Data(
      {this.sourceOfLimit,
      this.utilizationOfLimit,
      this.availableMargin,
      this.marginUsed,
      this.marginUsedPercentage,
      this.availableDerivativeMarginLimit,
      this.availableMarginLimit,
      this.availableDeliveryMarginLimitCNC,
      this.availableOptnBuyLimit,
      this.shortFall,
      this.cncrealizedmtomprsnt,
      this.deliverymarginprsnt,
      this.adhocscripmargin,
      this.brokerageprsnt,
      this.iPOAmount,
      this.bOmarginRequired,
      this.cdsspreadbenefit,
      this.scripbasketmargin,
      this.segment,
      this.equity,
      this.buyExposurePrsnt,
      this.grossCollateral,
      this.utilizedamount,
      this.branchadhoc,
      this.premiumpresent,
      this.mTM,
      this.sellExposurePrsnt,
      this.multiplier,
      this.elm,
      this.additionalpreexpirymarginprsnt,
      this.cOMarginRequired,
      this.nfospreadbenefit,
      this.valueindelivery,
      this.payoutAmt,
      this.losslimit,
      this.viewunrealizedmtom,
      this.cncmarginused,
      this.stockValuation,
      this.cncsellcreditpresent,
      this.mfssamountused,
      this.spanmargin,
      this.openingBalance,
      this.netcashavailable,
      this.bookedPNL,
      this.exposuremargin,
      this.unrealisedmtom,
      this.payinAmt,
      this.lien,
      this.viewrealizedmtom,
      this.unbookedPNL,
      this.cncMarginVarPrsnt,
      this.marginScripBasketCustomPresent,
      this.t1grossCollateral,
      this.adhoc,
      this.turnover,
      this.cncMarginElmPrsnt,
      this.grossexposurevalue,
      this.stat,
      this.buyPower,
      this.varmargin,
      this.mfamount,
      this.specialmarginprsnt,
      this.elbamount,
      this.directcollateralvalue,
      this.additionalmarginprsnt,
      this.realisedmtom,
      this.tendermarginprsnt,
      this.cncunrealizedmtomprsnt,
      this.financelimit,
      this.adhocmargin,
      this.category,
      this.cncbrokerageprsnt,
      this.notionalcash});

  Data.fromJson(Map<String, dynamic> json) {
    sourceOfLimit = json['Source_of_Limit'];
    utilizationOfLimit = json['Utilization_of_Limit'];
    availableMargin = json['AvailableMargin'];
    marginUsed = json['MarginUsed'];
    marginUsedPercentage = json['MarginUsed_Percentage'];
    availableDerivativeMarginLimit = json['AvailableDerivativeMarginLimit'];
    availableMarginLimit = json['AvailableMarginLimit'];
    availableDeliveryMarginLimitCNC = json['AvailableDeliveryMarginLimitCNC'];
    availableOptnBuyLimit = json['AvailableOptnBuyLimit'];
    shortFall = json['ShortFall'];
    cncrealizedmtomprsnt = json['Cncrealizedmtomprsnt'];
    deliverymarginprsnt = json['Deliverymarginprsnt'];
    adhocscripmargin = json['Adhocscripmargin'];
    brokerageprsnt = json['Brokerageprsnt'];
    iPOAmount = json['IPOAmount'];
    bOmarginRequired = json['BOmarginRequired'];
    cdsspreadbenefit = json['Cdsspreadbenefit'];
    scripbasketmargin = json['Scripbasketmargin'];
    segment = json['Segment'];
    equity = json['Equity'];
    buyExposurePrsnt = json['BuyExposurePrsnt'];
    grossCollateral = json['GrossCollateral'];
    utilizedamount = json['Utilizedamount'];
    branchadhoc = json['Branchadhoc'];
    premiumpresent = json['Premiumpresent'];
    mTM = json['MTM'];
    sellExposurePrsnt = json['SellExposurePrsnt'];
    multiplier = json['Multiplier'];
    elm = json['Elm'];
    additionalpreexpirymarginprsnt = json['Additionalpreexpirymarginprsnt'];
    cOMarginRequired = json['COMarginRequired'];
    nfospreadbenefit = json['Nfospreadbenefit'];
    valueindelivery = json['Valueindelivery'];
    payoutAmt = json['PayoutAmt'];
    losslimit = json['Losslimit'];
    viewunrealizedmtom = json['Viewunrealizedmtom'];
    cncmarginused = json['Cncmarginused'];
    stockValuation = json['StockValuation'];
    cncsellcreditpresent = json['Cncsellcreditpresent'];
    mfssamountused = json['Mfssamountused'];
    spanmargin = json['Spanmargin'];
    openingBalance = json['OpeningBalance'];
    netcashavailable = json['Netcashavailable'];
    bookedPNL = json['BookedPNL'];
    exposuremargin = json['Exposuremargin'];
    unrealisedmtom = json['Unrealisedmtom'];
    payinAmt = json['PayinAmt'];
    lien = json['Lien'];
    viewrealizedmtom = json['Viewrealizedmtom'];
    unbookedPNL = json['UnbookedPNL'];
    cncMarginVarPrsnt = json['CncMarginVarPrsnt'];
    marginScripBasketCustomPresent = json['MarginScripBasketCustomPresent'];
    t1grossCollateral = json['T1grossCollateral'];
    adhoc = json['Adhoc'];
    turnover = json['Turnover'];
    cncMarginElmPrsnt = json['CncMarginElmPrsnt'];
    grossexposurevalue = json['Grossexposurevalue'];
    stat = json['Stat'];
    buyPower = json['BuyPower'];
    varmargin = json['varmargin'];
    mfamount = json['Mfamount'];
    specialmarginprsnt = json['Specialmarginprsnt'];
    elbamount = json['Elbamount'];
    directcollateralvalue = json['Directcollateralvalue'];
    additionalmarginprsnt = json['Additionalmarginprsnt'];
    realisedmtom = json['Realisedmtom'];
    tendermarginprsnt = json['Tendermarginprsnt'];
    cncunrealizedmtomprsnt = json['Cncunrealizedmtomprsnt'];
    financelimit = json['Financelimit'];
    adhocmargin = json['Adhocmargin'];
    category = json['Category'];
    cncbrokerageprsnt = json['Cncbrokerageprsnt'];
    notionalcash = json['Notionalcash'];
  }
}
