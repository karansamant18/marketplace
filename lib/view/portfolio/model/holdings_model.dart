// To parse this JSON data, do
//
//     final holdingsModel = holdingsModelFromJson(jsonString);

import 'dart:convert';

HoldingsModel holdingsModelFromJson(String str) =>
    HoldingsModel.fromJson(json.decode(str));

// String holdingsModelToJson(HoldingsModel data) => json.encode(data.toJson());

class HoldingsModel {
  bool? status;
  String? message;
  String? errorcode;
  dynamic emsg;
  List<Holding>? data;

  HoldingsModel({
    required this.status,
    required this.message,
    required this.errorcode,
    this.emsg,
    required this.data,
  });

  HoldingsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    errorcode = json["errorcode"];
    emsg = json["emsg"] ?? "";
    data = <Holding>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(new Holding.fromJson(v));
      });
    }
  }
}

class Holding {
  String? tradingSymbol;
  String? symboltoken;
  String? exchange;
  String? isin;
  String? t1Quantity;
  String? realisedquantity;
  String? quantity;
  String? authorisedquantity;
  String? profitandloss;
  String? product;
  String? collateralquantity;
  String? collateraltype;
  String? haircut;
  String? price;
  double? ltp;
  double? invested;
  double? pnlPct;

  Holding({
    required this.tradingSymbol,
    required this.symboltoken,
    required this.exchange,
    required this.isin,
    required this.t1Quantity,
    required this.realisedquantity,
    required this.quantity,
    required this.authorisedquantity,
    required this.profitandloss,
    required this.product,
    required this.collateralquantity,
    required this.collateraltype,
    required this.haircut,
    required this.price,
    required this.ltp,
    required this.invested,
    required this.pnlPct,
  });

  Holding.fromJson(Map<String, dynamic> json) {
    tradingSymbol = json["tradingSymbol"];
    symboltoken = json["symboltoken"];
    exchange = json["exchange"];
    isin = json["isin"];
    t1Quantity = json["t1quantity"];
    realisedquantity = json["realisedquantity"];
    quantity = json["quantity"];
    authorisedquantity = json["authorisedquantity"];
    profitandloss = json["profitandloss"].toString().replaceAll(',', '');
    product = json["product"];
    collateralquantity = json["collateralquantity"];
    collateraltype = json["collateraltype"];
    haircut = json["haircut"];
    price = json["price"];
    ltp = 0.00;
    invested =
        int.parse(json["quantity"]) * double.parse(json["price"].toString());
    pnlPct = (double.parse(profitandloss!) / invested!) * 100;
  }
}
