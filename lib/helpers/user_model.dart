class ResponseModel<T> {
  int? status;
  String? message;
  T? data;

  ResponseModel({this.data, this.message, this.status});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}
