import 'dart:convert';

List<HomeQuoteModel> homeQuoteModelFromJson(String str) =>
    List<HomeQuoteModel>.from(
        json.decode(str).map((x) => HomeQuoteModel.fromJson(x)));

class HomeQuoteModel {
  String symbol;
  double ltp;
  double changePct;
  int symphonyToken;
  double symphonyLtp;

  HomeQuoteModel({
    required this.symbol,
    required this.ltp,
    required this.changePct,
    required this.symphonyToken,
    required this.symphonyLtp,
  });

  factory HomeQuoteModel.fromJson(Map<String, dynamic> json) => HomeQuoteModel(
        symbol: json["symbol"],
        ltp: double.parse(
            double.parse(json["ltp"].toString()).toStringAsFixed(2)),
        changePct: double.parse(
            double.parse(json["changePct"].toString()).toStringAsFixed(2)),
        symphonyToken: json["symphonyToken"] != null
            ? int.parse(json["symphonyToken"].toString())
            : 0,
        symphonyLtp: json["symphonyLtp"] != null
            ? double.parse(json["symphonyLtp"].toString())
            : 0.0,
      );
}
