class ReqMarginModel {
  String? timestamp;
  int? code;
  String? status;
  String? infoID;
  Null infoMsg;
  Data? data;

  ReqMarginModel(
      {this.timestamp,
      this.code,
      this.status,
      this.infoID,
      this.infoMsg,
      this.data});

  ReqMarginModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    code = json['code'];
    status = json['status'];
    infoID = json['infoID'];
    infoMsg = json['infoMsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  Map<String, dynamic>? requiredMargin;

  Data({this.requiredMargin});

  Data.fromJson(Map<String, dynamic> json) {
    requiredMargin = json['requiredMargin'] != null
        ? Map<String, dynamic>.from(json['requiredMargin'])
        : null;
  }
}

class Margin {
  double? marginPercent;
  double? slRange;

  Margin({this.marginPercent, this.slRange});

  Margin.fromJson(Map<String, dynamic> json) {
    marginPercent = json['marginPercent'];
    slRange = json['slRange'] ?? 0.0;
  }
}
