class UpdateNameModel {
  String? status;
  Data? data;

  UpdateNameModel({this.status, this.data});

  UpdateNameModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? doc;
  bool? isActive;
  String? role;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNo,
      this.doc,
      this.isActive,
      this.role});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNo = json['phoneNo'];
    doc = json['doc'];
    isActive = json['isActive'];
    role = json['role'];
  }
}
