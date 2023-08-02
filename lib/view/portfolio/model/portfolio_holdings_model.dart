// To parse this JSON data, do
//
//     final portfolioHoldings = portfolioHoldingsFromJson(jsonString?);

import 'dart:convert';

PortfolioHoldings portfolioHoldingsFromJson(String str) =>
    PortfolioHoldings.fromJson(json.decode(str));

// String? portfolioHoldingsToJson(PortfolioHoldings data) =>
//     json.encode(data.toJson());

class PortfolioHoldings {
  String? timestamp;
  double? code;
  String? status;
  String? infoId;
  dynamic infoMsg;
  Data? data;

  PortfolioHoldings({
    this.timestamp,
    this.code,
    this.status,
    this.infoId,
    this.infoMsg,
    this.data,
  });

  factory PortfolioHoldings.fromJson(Map<String?, dynamic> json) =>
      PortfolioHoldings(
        timestamp: json["timestamp"],
        code: json["code"].toDouble(),
        status: json["status"],
        infoId: json["infoID"],
        infoMsg: json["infoMsg"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Portfolio? portfolio;

  Data({
    this.portfolio,
  });

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
        portfolio: json["portfolio"] != null
            ? Portfolio.fromJson(json["portfolio"])
            : null,
      );
}

class Portfolio {
  String? reportDate;
  double? realisedIntraDayPL;
  double? realisedShortTermPl;
  double? realisedLongTermPl;
  double? totalRealisedPl;
  double? totalFnoRealisedPl;
  double? totalCurRealisedPl;
  double? totalComRealisedPl;
  List<EquityHolding>? equityHoldings;

  Portfolio({
    this.reportDate,
    this.realisedIntraDayPL,
    this.realisedShortTermPl,
    this.realisedLongTermPl,
    this.totalRealisedPl,
    this.totalFnoRealisedPl,
    this.totalCurRealisedPl,
    this.totalComRealisedPl,
    this.equityHoldings,
  });

  factory Portfolio.fromJson(Map<String?, dynamic> json) => Portfolio(
        reportDate: json["reportDate"],
        realisedIntraDayPL: json["realisedIntraDayPL"].toDouble(),
        realisedShortTermPl: json["realisedShortTermPL"],
        realisedLongTermPl: json["realisedLongTermPL"],
        totalRealisedPl: json["totalRealisedPL"].toDouble(),
        totalFnoRealisedPl: json["totalFNORealisedPL"],
        totalCurRealisedPl: json["totalCurRealisedPL"],
        totalComRealisedPl: json["totalComRealisedPL"],
        equityHoldings: List<EquityHolding>.from(
            json["equityHoldings"].map((x) => EquityHolding.fromJson(x))),
      );
}

class EquityHolding {
  double? praKey;
  String? clientCode;
  String? clientName;
  String? segmentCode;
  String? segmentName;
  String? fromDate;
  double? multiplier;
  double? openQty;
  double? openRate;
  double? openCost;
  double? buyQty;
  double? buyRate;
  String? buyDate;
  double? buyValue;
  double? buyAvgPrice;
  double? sellQty;
  double? sellRate;
  dynamic sellDate;
  double? sellValue;
  double? sellAvgPrice;
  double? netQty;
  double? netRate;
  double? netValue;
  double? valRate;
  String? valDateAndTime;
  double? valuation;
  String? ludt;
  Symbol? symbol;
  String? scripCode;
  String? scripName;
  String? isin;
  dynamic openDate;
  double? doubleraDayPl;
  double? realisedShortTermPl;
  double? realisedLongTermPl;
  double? unRealisedPl;
  String? valScripCode;
  // List<News>? news;
  // List<Dividend>? dividend;
  // List<Bonus>? bonus;
  // List<Split>? splits;
  // dynamic rights;
  // List<BoardMeeting>? boardMeetings;
  double? invested;
  EquityHolding({
    this.praKey,
    this.clientCode,
    this.clientName,
    this.segmentCode,
    this.segmentName,
    this.fromDate,
    this.multiplier,
    this.openQty,
    this.openRate,
    this.openCost,
    this.buyQty,
    this.buyRate,
    this.buyDate,
    this.buyValue,
    this.buyAvgPrice,
    this.sellQty,
    this.sellRate,
    this.sellDate,
    this.sellValue,
    this.sellAvgPrice,
    this.netQty,
    this.netRate,
    this.invested,
    this.netValue,
    this.valRate,
    this.valDateAndTime,
    this.valuation,
    this.ludt,
    this.symbol,
    this.scripCode,
    this.scripName,
    this.isin,
    this.openDate,
    this.doubleraDayPl,
    this.realisedShortTermPl,
    this.realisedLongTermPl,
    this.unRealisedPl,
    this.valScripCode,
    // this.news,
    // this.dividend,
    // this.bonus,
    // this.splits,
    // this.rights,
    // this.boardMeetings,
  });

  factory EquityHolding.fromJson(Map<String?, dynamic> json) => EquityHolding(
        praKey: json["praKey"].toDouble(),
        clientCode: json["clientCode"],
        clientName: json["clientName"],
        segmentCode: json["segmentCode"],
        segmentName: json["segmentName"],
        fromDate: json["fromDate"],
        multiplier: json["multiplier"].toDouble(),
        openQty: json["openQty"].toDouble(),
        openRate: json["openRate"].toDouble(),
        openCost: json["openCost"].toDouble(),
        buyQty: json["buyQty"].toDouble(),
        buyRate: json["buyRate"].toDouble(),
        buyDate: json["buyDate"],
        buyValue: json["buyValue"].toDouble(),
        buyAvgPrice: json["buyAvgPrice"].toDouble(),
        sellQty: json["sellQty"],
        sellRate: json["sellRate"],
        sellDate: json["sellDate"],
        sellValue: json["sellValue"],
        sellAvgPrice: json["sellAvgPrice"],
        netQty: json["netQty"],
        netRate: json["netRate"].toDouble(),
        netValue: json["netValue"].toDouble(),
        invested: json["netQty"].toDouble() * json["netRate"].toDouble(),
        valRate: json["valRate"].toDouble(),
        valDateAndTime: json["valDateAndTime"],
        valuation: json["valuation"].toDouble(),
        ludt: json["ludt"],
        symbol: Symbol.fromJson(json["symbol"]),
        scripCode: json["scripCode"],
        scripName: json["scripName"],
        isin: json["isin"],
        openDate: json["openDate"],
        doubleraDayPl: json["doubleraDayPL"],
        realisedShortTermPl: json["realisedShortTermPL"],
        realisedLongTermPl: json["realisedLongTermPL"],
        unRealisedPl: json["unRealisedPL"].toDouble(),
        valScripCode: json["valScripCode"],
        // news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
        // dividend: List<Dividend>.from(
        //     json["dividend"].map((x) => Dividend.fromJson(x))),
        // bonus: json["bonus"] != null
        //     ? List<Bonus>.from(json["bonus"].map((x) => Bonus.fromJson(x)))
        //     : [],
        // splits: json["splits"] == null
        //     ? []
        //     : List<Split>.from(json["splits"].map((x) => Split.fromJson(x))),
        // rights: json["rights"],
        // boardMeetings: json["boardMeetings"] == null
        //     ? []
        //     : List<BoardMeeting>.from(
        //         json["boardMeetings"].map((x) => BoardMeeting.fromJson(x))),
      );
}

class BoardMeeting {
  String? symbol;
  String? bMdate;
  String? announcementDate;
  String? description;
  double? coCode;
  String? isin;
  String? coName;

  BoardMeeting({
    this.symbol,
    this.bMdate,
    this.announcementDate,
    this.description,
    this.coCode,
    this.isin,
    this.coName,
  });

  factory BoardMeeting.fromJson(Map<String?, dynamic> json) => BoardMeeting(
        symbol: json["symbol"],
        bMdate: json["BMdate"],
        announcementDate: json["AnnouncementDate"],
        description: json["Description"],
        coCode: json["co_code"],
        isin: json["isin"],
        coName: json["co_name"],
      );
}

class Bonus {
  String? symbol;
  String? announcementDate;
  String? description;
  String? recordDate;
  String? bonusRatio;
  String? remark;
  double? coCode;
  String? bonusDate;
  String? isin;
  String? coName;

  Bonus({
    this.symbol,
    this.announcementDate,
    this.description,
    this.recordDate,
    this.bonusRatio,
    this.remark,
    this.coCode,
    this.bonusDate,
    this.isin,
    this.coName,
  });

  factory Bonus.fromJson(Map<String?, dynamic> json) => Bonus(
        symbol: json["symbol"],
        announcementDate: json["AnnouncementDate"],
        description: json["Description"],
        recordDate: json["RecordDate"],
        bonusRatio: json["BonusRatio"],
        remark: json["remark"],
        coCode: json["co_code"],
        bonusDate: json["BonusDate"],
        isin: json["isin"],
        coName: json["co_name"],
      );
}

class Dividend {
  String? symbol;
  String? announcementDate;
  String? description;
  double? divPer;
  String? recordDate;
  String? divDate;
  double? divAmount;
  String? dividendPayoutDate;
  String? dividendType;
  double? coCode;
  String? isin;
  String? coName;

  Dividend({
    this.symbol,
    this.announcementDate,
    this.description,
    this.divPer,
    this.recordDate,
    this.divDate,
    this.divAmount,
    this.dividendPayoutDate,
    this.dividendType,
    this.coCode,
    this.isin,
    this.coName,
  });

  factory Dividend.fromJson(Map<String?, dynamic> json) => Dividend(
        symbol: json["symbol"],
        announcementDate: json["AnnouncementDate"],
        description: json["Description"],
        divPer: json["DivPer"].toDouble(),
        recordDate: json["RecordDate"],
        divDate: json["DivDate"],
        divAmount: json["DivAmount"].toDouble(),
        dividendPayoutDate: json["DividendPayoutDate"],
        dividendType: json["DividendType"],
        coCode: json["co_code"],
        isin: json["isin"],
        coName: json["co_name"],
      );
}

class News {
  String? date;
  double? sno;
  String? heading;
  String? caption;
  String? time;
  double? coCode;
  String? arttext;
  String? sectionname;
  String? coName;

  News({
    this.date,
    this.sno,
    this.heading,
    this.caption,
    this.time,
    this.coCode,
    this.arttext,
    this.sectionname,
    this.coName,
  });

  factory News.fromJson(Map<String?, dynamic> json) => News(
        date: json["DATE"],
        sno: json["sno"].toDouble(),
        heading: json["heading"],
        caption: json["caption"],
        time: json["time"],
        coCode: json["co_code"].toDouble(),
        arttext: json["arttext"],
        sectionname: json["sectionname"],
        coName: json["co_name"],
      );
}

class Split {
  String? splitRatio;
  String? symbol;
  String? announcementDate;
  String? description;
  double? fvBefore;
  dynamic noDeliveryEndDate;
  String? remark;
  String? recorddate;
  String? splitDate;
  dynamic noDeliveryStartDate;
  double? fvAfter;
  double? coCode;
  String? isin;
  String? coName;

  Split({
    this.splitRatio,
    this.symbol,
    this.announcementDate,
    this.description,
    this.fvBefore,
    this.noDeliveryEndDate,
    this.remark,
    this.recorddate,
    this.splitDate,
    this.noDeliveryStartDate,
    this.fvAfter,
    this.coCode,
    this.isin,
    this.coName,
  });

  factory Split.fromJson(Map<String?, dynamic> json) => Split(
        splitRatio: json["SplitRatio"],
        symbol: json["symbol"],
        announcementDate: json["AnnouncementDate"],
        description: json["Description"],
        fvBefore: json["FVBefore"],
        noDeliveryEndDate: json["NoDeliveryEndDate"],
        remark: json["remark"],
        recorddate: json["recorddate"],
        splitDate: json["SplitDate"],
        noDeliveryStartDate: json["NoDeliveryStartDate"],
        fvAfter: json["FVAfter"],
        coCode: json["co_code"],
        isin: json["isin"],
        coName: json["co_name"],
      );
}

class Symbol {
  String? symbol;
  String? baseSym;
  String? dispSym;
  String? streamSym;
  String? tradingSym;
  String? description;
  String? exc;
  String? instrumentType;
  dynamic optionType;
  String? isin;
  String? lotSize;
  String? tickSize;
  String? multiplier;
  String? series;
  dynamic expiry;
  double? strikePrice;
  String? marketCapType;
  String? sectorName;
  String? segment;
  double? ltp;
  double? pnl;
  double? pnlPct;

  Symbol({
    this.symbol,
    this.baseSym,
    this.dispSym,
    this.streamSym,
    this.tradingSym,
    this.description,
    this.exc,
    this.instrumentType,
    this.optionType,
    this.isin,
    this.lotSize,
    this.tickSize,
    this.multiplier,
    this.series,
    this.expiry,
    this.strikePrice,
    this.marketCapType,
    this.sectorName,
    this.segment,
    this.ltp,
    this.pnl,
    this.pnlPct,
  });

  factory Symbol.fromJson(Map<String?, dynamic> json) => Symbol(
        symbol: json["symbol"],
        baseSym: json["baseSym"],
        dispSym: json["dispSym"],
        streamSym: json["streamSym"],
        tradingSym: json["tradingSym"],
        description: json["description"],
        exc: json["exc"],
        instrumentType: json["instrumentType"],
        optionType: json["optionType"],
        isin: json["isin"],
        lotSize: json["lotSize"],
        tickSize: json["tickSize"],
        multiplier: json["multiplier"],
        series: json["series"],
        expiry: json["expiry"],
        strikePrice: json["strikePrice"],
        marketCapType: json["marketCapType"],
        sectorName: json["sectorName"],
        segment: json["segment"],
        ltp: 0,
        pnl: 0,
        pnlPct: 0,
      );
}
