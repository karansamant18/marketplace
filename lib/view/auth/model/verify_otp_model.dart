class VerifyOTPModel {
  String? status;
  Data? data;

  VerifyOTPModel({this.status, this.data});

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? accessToken;
  bool? profile;
  String? userName;
  String? phoneNo;

  Data({this.accessToken, this.profile, this.userName, this.phoneNo});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    profile = json['profile'];
    userName = json['userName'];
    phoneNo = json['phoneNo'];
  }
}
