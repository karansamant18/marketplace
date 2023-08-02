// To parse this JSON data, do
//
//     final basketProposalModel = basketProposalModelFromJson(jsonString);

import 'dart:convert';

BasketProposalModel basketProposalModelFromJson(String str) =>
    BasketProposalModel.fromJson(json.decode(str));

// String basketProposalModelToJson(BasketProposalModel data) => json.encode(data.toJson());

class BasketProposalModel {
  String? status;
  Data? data;

  BasketProposalModel({
    required this.status,
    required this.data,
  });

  factory BasketProposalModel.fromJson(Map<String, dynamic> json) =>
      BasketProposalModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String? userId;
  String? productId;
  int? proposedInvestAmt;
  List<PortfolioUnit>? portfolioUnits;
  Map<String, double>? grpAllocations;
  int assetCount;

  Data({
    required this.userId,
    required this.productId,
    required this.proposedInvestAmt,
    required this.portfolioUnits,
    required this.grpAllocations,
    required this.assetCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userID"],
        productId: json["productID"],
        proposedInvestAmt: json["proposedInvestAmt"],
        portfolioUnits: List<PortfolioUnit>.from(
            json["portfolioUnits"].map((x) => PortfolioUnit.fromJson(x))),
        grpAllocations: Map<String, double>.from(json["grpAllocations"]),
        assetCount: json["assetCount"],
      );
}

class PortfolioUnit {
  String eleverSecId;
  String isin;
  String secName;
  String secSymbol;
  String grpTag;
  int units;
  double investAvgPrice;
  int investAmt;
  double lastUpdatedPrice;
  int lastUpdatedValue;
  DateTime lastUpdatedValueAt;
  DateTime createdAt;
  DateTime lastUpdatedAt;

  PortfolioUnit({
    required this.eleverSecId,
    required this.isin,
    required this.secName,
    required this.secSymbol,
    required this.grpTag,
    required this.units,
    required this.investAvgPrice,
    required this.investAmt,
    required this.lastUpdatedPrice,
    required this.lastUpdatedValue,
    required this.lastUpdatedValueAt,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  factory PortfolioUnit.fromJson(Map<String, dynamic> json) => PortfolioUnit(
        eleverSecId: json["eleverSecID"],
        isin: json["isin"],
        secName: json["secName"],
        secSymbol: json["secSymbol"],
        grpTag: json["grpTag"],
        units: json["units"],
        investAvgPrice: json["investAvgPrice"]?.toDouble(),
        investAmt: json["investAmt"],
        lastUpdatedPrice: json["lastUpdatedPrice"]?.toDouble(),
        lastUpdatedValue: json["lastUpdatedValue"],
        lastUpdatedValueAt: DateTime.parse(json["lastUpdatedValueAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        lastUpdatedAt: DateTime.parse(json["lastUpdatedAt"]),
      );
}
