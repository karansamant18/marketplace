// To parse this JSON data, do
//
//     final basketPerfModel = basketPerfModelFromJson(jsonString);

import 'dart:convert';

BasketPerfModel basketPerfModelFromJson(String str) =>
    BasketPerfModel.fromJson(json.decode(str));

// String basketPerfModelToJson(BasketPerfModel data) => json.encode(data.toJson());

class BasketPerfModel {
  String? status;
  Data? data;

  BasketPerfModel({
    required this.status,
    required this.data,
  });

  factory BasketPerfModel.fromJson(Map<String, dynamic> json) =>
      BasketPerfModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String? productId;
  ProductSeries? productSeries;
  List<ProductSeries>? benchmarkSeries;

  Data({
    required this.productId,
    required this.productSeries,
    required this.benchmarkSeries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        productId: json["productID"],
        productSeries: ProductSeries.fromJson(json["productSeries"]),
        benchmarkSeries: List<ProductSeries>.from(
            json["benchmarkSeries"].map((x) => ProductSeries.fromJson(x))),
      );
}

class ProductSeries {
  String? seriesName;
  bool? isBenchmark;
  DateTime? lastUpdatedAt;
  List<AnnualizedReturn>? monthlyReturnList;
  List<AnnualizedReturn>? annualizedReturn;
  List<AnnualizedReturn>? sipReturn;

  ProductSeries({
    required this.seriesName,
    required this.isBenchmark,
    required this.lastUpdatedAt,
    required this.monthlyReturnList,
    required this.annualizedReturn,
    required this.sipReturn,
  });

  factory ProductSeries.fromJson(Map<String, dynamic> json) => ProductSeries(
        seriesName: json["seriesName"],
        isBenchmark: json["isBenchmark"],
        lastUpdatedAt: DateTime.parse(json["lastUpdatedAt"]),
        monthlyReturnList: List<AnnualizedReturn>.from(
            json["monthlyReturnList"].map((x) => AnnualizedReturn.fromJson(x))),
        annualizedReturn: List<AnnualizedReturn>.from(
            json["AnnualizedReturn"].map((x) => AnnualizedReturn.fromJson(x))),
        sipReturn: List<AnnualizedReturn>.from(
            json["SipReturn"].map((x) => AnnualizedReturn.fromJson(x))),
      );
}

class AnnualizedReturn {
  String? label;
  String? value;

  AnnualizedReturn({
    required this.label,
    required this.value,
  });

  factory AnnualizedReturn.fromJson(Map<String, dynamic> json) =>
      AnnualizedReturn(
        label: json["label"],
        value: json["value"],
      );
}
