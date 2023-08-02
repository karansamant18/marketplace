// To parse this JSON data, do
//
//     final postTradeModel = postTradeModelFromJson(jsonString);

import 'dart:convert';

PostTradeModel postTradeModelFromJson(String str) =>
    PostTradeModel.fromJson(json.decode(str));

// String postTradeModelToJson(PostTradeModel data) => json.encode(data.toJson());

class PostTradeModel {
  String? status;
  List<InvestedBasket>? data;

  PostTradeModel({
    required this.status,
    required this.data,
  });

  factory PostTradeModel.fromJson(Map<String, dynamic> json) => PostTradeModel(
        status: json["status"],
        data: List<InvestedBasket>.from(
            json["data"].map((x) => InvestedBasket.fromJson(x))),
      );
}

class InvestedBasket {
  String? productInstanceId;
  String? userId;
  String? productId;
  String? productGrpId;
  String? productInstanceName;
  String? riskProfile;
  double? contributeAmt;
  String? investFreq;
  String? activatedAt;
  String? nextSipDueAt;
  double? stepUpSip;
  double? investedAmt;
  double? lastUpdatedValue;
  double? currentReturns;
  double? returnPercent;
  List<Unit>? units;
  Map<String, double>? grpAllocations;
  int? assetCount;
  String? lastRebalancedOn;
  String? rebalanceFrequency;
  String? dashboardStatus;
  String? statusMessage;
  String? statusColor;
  String? contextualActionId;
  String? contextualActionText;
  String? contextualOrderId;
  List<String>? otherAllowedActions;
  String? reBalanceEventReason;
  int? target;
  String? targetAt;
  int? term;

  InvestedBasket({
    required this.productInstanceId,
    required this.userId,
    required this.productId,
    required this.productGrpId,
    required this.productInstanceName,
    required this.riskProfile,
    required this.contributeAmt,
    required this.investFreq,
    required this.activatedAt,
    required this.nextSipDueAt,
    required this.stepUpSip,
    required this.investedAmt,
    required this.lastUpdatedValue,
    required this.currentReturns,
    required this.returnPercent,
    required this.units,
    required this.grpAllocations,
    required this.assetCount,
    required this.lastRebalancedOn,
    required this.rebalanceFrequency,
    required this.dashboardStatus,
    required this.statusMessage,
    required this.statusColor,
    required this.contextualActionId,
    required this.contextualActionText,
    required this.contextualOrderId,
    required this.otherAllowedActions,
    this.reBalanceEventReason,
    this.target,
    this.targetAt,
    this.term,
  });

  factory InvestedBasket.fromJson(Map<String, dynamic> json) => InvestedBasket(
        productInstanceId: json["productInstanceID"],
        userId: json["userID"],
        productId: json["productID"],
        productGrpId: json["productGrpID"],
        productInstanceName: json["productInstanceName"],
        riskProfile: json["riskProfile"],
        contributeAmt: double.parse(json["contributeAmt"].toString()),
        investFreq: json["investFreq"],
        activatedAt: json["activatedAt"],
        nextSipDueAt: json["nextSipDueAt"],
        stepUpSip: double.parse(json["stepUpSip"].toString()),
        investedAmt: double.parse(json["investedAmt"].toString()),
        lastUpdatedValue: double.parse(json["lastUpdatedValue"].toString()),
        currentReturns: double.parse(json["currentReturns"].toString()),
        returnPercent: double.parse(json["returnPercent"].toString()),
        units: List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
        grpAllocations: Map<String, double>.from(json["grpAllocations"]),
        assetCount: json["assetCount"],
        lastRebalancedOn: json["lastRebalancedOn"],
        rebalanceFrequency: json["rebalanceFrequency"],
        dashboardStatus: json["dashboardStatus"],
        statusMessage: json["statusMessage"],
        statusColor: json["statusColor"],
        contextualActionId: json["contextualActionID"],
        contextualActionText: json["contextualActionText"],
        contextualOrderId: json["contextualOrderID"],
        otherAllowedActions: json["otherAllowedActions"] != null
            ? List<String>.from(json["otherAllowedActions"].map((x) => x))
            : [],
        reBalanceEventReason: json["reBalanceEventReason"] ?? "",
        target: json["target"] ?? 0,
        targetAt: json["targetAt"] ?? "",
        term: json["term"] ?? 0,
      );
}

class GrpAllocations {
  double largeCap;
  double midCap;

  GrpAllocations({
    required this.largeCap,
    required this.midCap,
  });

  factory GrpAllocations.fromJson(Map<String, dynamic> json) => GrpAllocations(
        largeCap: json["LargeCap"]?.toDouble(),
        midCap: json["MidCap"]?.toDouble(),
      );
}

class Unit {
  String portfolioId;
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

  Unit({
    required this.portfolioId,
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

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        portfolioId: json["portfolioID"],
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
