// To parse this JSON data, do
//
//     final investSummaryModel = investSummaryModelFromJson(jsonString);

import 'dart:convert';

InvestSummaryModel investSummaryModelFromJson(String str) =>
    InvestSummaryModel.fromJson(json.decode(str));

// String investSummaryModelToJson(InvestSummaryModel data) => json.encode(data.toJson());

class InvestSummaryModel {
  String status;
  Data data;

  InvestSummaryModel({
    required this.status,
    required this.data,
  });

  factory InvestSummaryModel.fromJson(Map<String, dynamic> json) =>
      InvestSummaryModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Ggl02 ggl02;

  Data({
    required this.ggl02,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ggl02: Ggl02.fromJson(json["GGL02"]),
      );
}

class Ggl02 {
  String productGrpName;
  int activeInstances;
  int totalInvested;
  int currentValue;
  int currentReturns;
  double returnPercent;

  Ggl02({
    required this.productGrpName,
    required this.activeInstances,
    required this.totalInvested,
    required this.currentValue,
    required this.currentReturns,
    required this.returnPercent,
  });

  factory Ggl02.fromJson(Map<String, dynamic> json) => Ggl02(
        productGrpName: json["productGrpName"],
        activeInstances: json["activeInstances"],
        totalInvested: json["totalInvested"],
        currentValue: json["currentValue"],
        currentReturns: json["currentReturns"],
        returnPercent: json["returnPercent"]?.toDouble(),
      );
}
