import 'dart:convert';

class InstrumentsQuoteModel {
  String? type;
  String? code;
  String? description;
  Result? result;

  InstrumentsQuoteModel({this.type, this.code, this.description, this.result});

  InstrumentsQuoteModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    description = json['description'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }
}

class Result {
  int? mdp;
  List<QuotesList>? quotesList;
  List<InstrumentQuote>? listQuotes;

  Result({this.mdp, this.quotesList, this.listQuotes});

  Result.fromJson(Map<String, dynamic> json) {
    mdp = json['mdp'];
    if (json['quotesList'] != null) {
      quotesList = <QuotesList>[];
      json['quotesList'].forEach((v) {
        quotesList!.add(new QuotesList.fromJson(v));
      });
    }
    if (json['listQuotes'] != null) {
      listQuotes = <InstrumentQuote>[];
      json['listQuotes'].forEach((v) {
        listQuotes!.add(InstrumentQuote.fromJson(
            jsonDecode(v.toString().replaceAll("\\", ""))));
      });
    }
  }
}

class QuotesList {
  int? exchangeSegment;
  int? exchangeInstrumentID;

  QuotesList({this.exchangeSegment, this.exchangeInstrumentID});

  QuotesList.fromJson(Map<String, dynamic> json) {
    exchangeSegment = json['exchangeSegment'];
    exchangeInstrumentID = json['exchangeInstrumentID'];
  }
}

class InstrumentQuote {
  int? messageCode;
  int? messageVersion;
  int? applicationType;
  int? tokenID;
  int? exchangeSegment;
  int? exchangeInstrumentID;
  int? exchangeTimeStamp;
  // List<Bids>? bids;
  // List<Asks>? asks;
  Touchline? touchline;
  int? bookType;
  int? xMarketType;
  int? sequenceNumber;

  InstrumentQuote(
      {this.messageCode,
      this.messageVersion,
      this.applicationType,
      this.tokenID,
      this.exchangeSegment,
      this.exchangeInstrumentID,
      this.exchangeTimeStamp,
      this.touchline,
      this.bookType,
      this.xMarketType,
      this.sequenceNumber});

  InstrumentQuote.fromJson(Map<String, dynamic> json) {
    messageCode = json['MessageCode'];
    messageVersion = json['MessageVersion'];
    applicationType = json['ApplicationType'];
    tokenID = json['TokenID'];
    exchangeSegment = json['ExchangeSegment'];
    exchangeInstrumentID = json['ExchangeInstrumentID'];
    exchangeTimeStamp = json['ExchangeTimeStamp'];
    touchline = json['Touchline'] != null
        ? new Touchline.fromJson(json['Touchline'])
        : null;
    bookType = json['BookType'];
    xMarketType = json['XMarketType'];
    sequenceNumber = json['SequenceNumber'];
  }
}

class Bids {
  int? size;
  double? price;
  int? totalOrders;
  int? buyBackMarketMaker;

  Bids({this.size, this.price, this.totalOrders, this.buyBackMarketMaker});

  Bids.fromJson(Map<String, dynamic> json) {
    size = json['Size'];
    price = json['Price'].toDouble();
    totalOrders = json['TotalOrders'];
    buyBackMarketMaker = json['BuyBackMarketMaker'];
  }
}

class Touchline {
  Bids? bidInfo;
  Bids? askInfo;
  double? lastTradedPrice;
  int? lastTradedQunatity;
  int? totalBuyQuantity;
  int? totalSellQuantity;
  int? totalTradedQuantity;
  double? averageTradedPrice;
  int? lastTradedTime;
  int? lastUpdateTime;
  double? percentChange;
  double? open;
  double? high;
  double? low;
  double? close;
  int? totalValueTraded;
  int? buyBackTotalBuy;
  int? buyBackTotalSell;

  Touchline(
      {this.bidInfo,
      this.askInfo,
      this.lastTradedPrice,
      this.lastTradedQunatity,
      this.totalBuyQuantity,
      this.totalSellQuantity,
      this.totalTradedQuantity,
      this.averageTradedPrice,
      this.lastTradedTime,
      this.lastUpdateTime,
      this.percentChange,
      this.open,
      this.high,
      this.low,
      this.close,
      this.totalValueTraded,
      this.buyBackTotalBuy,
      this.buyBackTotalSell});

  Touchline.fromJson(Map<String, dynamic> json) {
    bidInfo =
        json['BidInfo'] != null ? new Bids.fromJson(json['BidInfo']) : null;
    askInfo =
        json['AskInfo'] != null ? new Bids.fromJson(json['AskInfo']) : null;
    lastTradedPrice = json['LastTradedPrice'].toDouble();
    lastTradedQunatity = json['LastTradedQunatity'];
    totalBuyQuantity = json['TotalBuyQuantity'];
    totalSellQuantity = json['TotalSellQuantity'];
    totalTradedQuantity = json['TotalTradedQuantity'];
    averageTradedPrice = json['AverageTradedPrice'].toDouble();
    lastTradedTime = json['LastTradedTime'];
    lastUpdateTime = json['LastUpdateTime'];
    percentChange = json['PercentChange'].toDouble();
    open = json['Open'].toDouble();
    high = json['High'].toDouble();
    low = json['Low'].toDouble();
    close = json['Close'].toDouble();
    totalValueTraded = json['TotalValueTraded'] ?? 0;
    buyBackTotalBuy = json['BuyBackTotalBuy'];
    buyBackTotalSell = json['BuyBackTotalSell'];
  }
}
