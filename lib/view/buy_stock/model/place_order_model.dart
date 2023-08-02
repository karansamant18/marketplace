class PlaceOrderModel {
  bool? status;
  String? message;
  String? errorcode;
  String? emsg;
  Data? data;

  PlaceOrderModel(
      {this.status, this.message, this.errorcode, this.emsg, this.data});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
    emsg = json['emsg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? script;
  String? orderid;

  Data({this.script, this.orderid});

  Data.fromJson(Map<String, dynamic> json) {
    script = json['script'];
    orderid = json['orderid'];
  }
}
