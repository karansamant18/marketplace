// To parse this JSON data, do
//
//     final basketIntroModel = basketIntroModelFromJson(jsonString);

import 'dart:convert';

BasketIntroModel basketIntroModelFromJson(String str) =>
    BasketIntroModel.fromJson(json.decode(str));

// String basketIntroModelToJson(BasketIntroModel data) => json.encode(data.toJson());

class BasketIntroModel {
  String? status;
  Data? data;

  BasketIntroModel({
    required this.status,
    required this.data,
  });

  factory BasketIntroModel.fromJson(Map<String, dynamic> json) =>
      BasketIntroModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  BasketInfo? basketInfo;
  SubscriptionPlanInfo? subscriptionPlanInfo;

  Data({
    required this.basketInfo,
    required this.subscriptionPlanInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        basketInfo: BasketInfo.fromJson(json["basketInfo"]),
        subscriptionPlanInfo:
            SubscriptionPlanInfo.fromJson(json["subscriptionPlanInfo"]),
      );
}

class BasketInfo {
  String? productId;
  String? productGrpId;
  String? productName;
  String? shortDescription;
  String? fullDescription;
  int? minInvestAmt;
  int? maxInvestAmt;
  int? adhocMinInvestAmt;
  String? cagr;
  String? volatility;
  int? priority;
  String? factSheetUrl;
  List<String>? methodologyTextList;
  String? imageFormat;
  String? iconUrl;
  String? infoVideoUrl;
  Map<String, double>? grpAllocations;
  String? lastRebalancedOn;
  String? rebalanceFrequency;
  int? assetCount;
  List<DiscountTier>? discountTiers;

  BasketInfo({
    required this.productId,
    required this.productGrpId,
    required this.productName,
    required this.shortDescription,
    required this.fullDescription,
    required this.minInvestAmt,
    required this.maxInvestAmt,
    required this.adhocMinInvestAmt,
    required this.cagr,
    required this.volatility,
    required this.priority,
    required this.factSheetUrl,
    required this.methodologyTextList,
    required this.imageFormat,
    required this.iconUrl,
    required this.infoVideoUrl,
    required this.grpAllocations,
    required this.lastRebalancedOn,
    required this.rebalanceFrequency,
    required this.assetCount,
    required this.discountTiers,
  });

  factory BasketInfo.fromJson(Map<String, dynamic> json) => BasketInfo(
        productId: json["productID"],
        productGrpId: json["productGrpID"],
        productName: json["productName"],
        shortDescription: json["shortDescription"],
        fullDescription: json["fullDescription"],
        minInvestAmt: json["minInvestAmt"],
        maxInvestAmt: json["maxInvestAmt"],
        adhocMinInvestAmt: json["adhocMinInvestAmt"],
        cagr: json["cagr"],
        volatility: json["volatility"],
        priority: json["priority"],
        factSheetUrl: json["factSheetUrl"],
        methodologyTextList:
            List<String>.from(json["methodologyTextList"].map((x) => x)),
        imageFormat: json["imageFormat"],
        iconUrl: json["iconUrl"],
        infoVideoUrl: json["infoVideoUrl"],
        grpAllocations: Map<String, double>.from(json["grpAllocations"]),
        // grpAllocations: Map..fromJson(json["grpAllocations"]),
        lastRebalancedOn: json["lastRebalancedOn"],
        rebalanceFrequency: json["rebalanceFrequency"],
        assetCount: json["assetCount"],
        discountTiers: List<DiscountTier>.from(
            json["discountTiers"].map((x) => DiscountTier.fromJson(x))),
      );
}

class DiscountTier {
  int? limit;
  double? ratePer;

  DiscountTier({
    required this.limit,
    required this.ratePer,
  });

  factory DiscountTier.fromJson(Map<String, dynamic> json) => DiscountTier(
        limit: json["limit"],
        ratePer: json["ratePer"]?.toDouble(),
      );
}

class GrpAllocations {
  double? largeCap;
  double? midCap;

  GrpAllocations({
    required this.largeCap,
    required this.midCap,
  });

  factory GrpAllocations.fromJson(Map<String, dynamic> json) => GrpAllocations(
        largeCap: json["LargeCap"]?.toDouble(),
        midCap: json["MidCap"]?.toDouble(),
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
  int? partnerFlatRate;
  String? flatRateType;
  dynamic tiers;
  DateTime? activatedAt;
  DateTime? retiredAt;
  bool? isRetired;

  SubscriptionPlanInfo({
    required this.planId,
    required this.productGrpId,
    required this.productId,
    required this.chargingModel,
    required this.chargingBasis,
    required this.chargingUnit,
    required this.flatRate,
    required this.partnerFlatRate,
    required this.flatRateType,
    this.tiers,
    required this.activatedAt,
    required this.retiredAt,
    required this.isRetired,
  });

  factory SubscriptionPlanInfo.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanInfo(
        planId: json["planID"],
        productGrpId: json["productGrpID"],
        productId: json["productID"],
        chargingModel: json["chargingModel"],
        chargingBasis: json["chargingBasis"],
        chargingUnit: json["chargingUnit"],
        flatRate: json["flatRate"],
        partnerFlatRate: json["partnerFlatRate"],
        flatRateType: json["flatRateType"],
        tiers: json["tiers"],
        activatedAt: DateTime.parse(json["activatedAt"]),
        retiredAt: DateTime.parse(json["retiredAt"]),
        isRetired: json["isRetired"],
      );
}
