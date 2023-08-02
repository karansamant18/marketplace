class SendOTPModel {
  String? status;
  Data? data;

  SendOTPModel({this.status, this.data});

  SendOTPModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? message;
  String? phoneNo;

  Data({this.message, this.phoneNo});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    phoneNo = json['phoneNo'];
  }
}
