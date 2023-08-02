// To parse this JSON data, do
//
//     final basketModel = basketModelFromJson(jsonString?);

import 'dart:convert';

BasketModel basketModelFromJson(String str) =>
    BasketModel.fromJson(json.decode(str));

// String? basketModelToJson(BasketModel data) => json.encode(data.toJson());

class BasketModel {
  String? status;
  List<Basket>? data;

  BasketModel({
    this.status,
    this.data,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) => BasketModel(
        status: json["status"],
        data: List<Basket>.from(json["data"].map((x) => Basket.fromJson(x))),
      );
}

class Basket {
  String? productId;
  String? productGrpId;
  String? productName;
  String? shortDescription;
  String? fullDescription;
  double? minInvestAmt;
  double? maxInvestAmt;
  int? adhocMinInvestAmt;
  String? cagr;
  String? volatility;
  int? priority;
  String? lastRebalancedOn;
  SubscriptionPlanInfo? subscriptionPlanInfo;

  Basket({
    this.productId,
    this.productGrpId,
    this.productName,
    this.shortDescription,
    this.fullDescription,
    this.minInvestAmt,
    this.maxInvestAmt,
    this.adhocMinInvestAmt,
    this.cagr,
    this.volatility,
    this.priority,
    this.lastRebalancedOn,
    this.subscriptionPlanInfo,
  });

  factory Basket.fromJson(Map<String?, dynamic> json) => Basket(
        productId: json["productID"],
        productGrpId: json["productGrpID"],
        productName: json["productName"],
        shortDescription: json["shortDescription"],
        fullDescription: json["fullDescription"],
        minInvestAmt: double.parse(json["minInvestAmt"].toString()),
        maxInvestAmt: double.parse(json["maxInvestAmt"].toString()),
        adhocMinInvestAmt: json["adhocMinInvestAmt"],
        cagr: json["cagr"],
        volatility: json["volatility"],
        priority: json["priority"],
        lastRebalancedOn: json["lastRebalancedOn"],
        subscriptionPlanInfo:
            SubscriptionPlanInfo.fromJson(json["subscriptionPlanInfo"]),
      );
}

class SubscriptionPlanInfo {
  String? planId;
  String? productGrpId;
  String? productId;
  String? chargingModel;
  String? chargingBasis;
  String? chargingUnit;
  int? flatRate;
  String? flatRateType;
  dynamic tiers;
  String? activatedAt;
  String? retiredAt;
  bool? isRetired;

  SubscriptionPlanInfo({
    this.planId,
    this.productGrpId,
    this.productId,
    this.chargingModel,
    this.chargingBasis,
    this.chargingUnit,
    this.flatRate,
    this.flatRateType,
    this.tiers,
    this.activatedAt,
    this.retiredAt,
    this.isRetired,
  });

  factory SubscriptionPlanInfo.fromJson(Map<String?, dynamic> json) =>
      SubscriptionPlanInfo(
        planId: json["planID"],
        productGrpId: json["productGrpID"],
        productId: json["productID"],
        chargingModel: json["chargingModel"],
        chargingBasis: json["chargingBasis"],
        chargingUnit: json["chargingUnit"],
        flatRate: json["flatRate"],
        flatRateType: json["flatRateType"],
        tiers: json["tiers"],
        activatedAt: json["activatedAt"],
        retiredAt: json["retiredAt"],
        isRetired: json["isRetired"],
      );
}
