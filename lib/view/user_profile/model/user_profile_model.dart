// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

// String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  bool status;
  String message;
  String errorcode;
  dynamic emsg;
  UserProfile data;

  UserProfileModel({
    required this.status,
    required this.message,
    required this.errorcode,
    this.emsg,
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        status: json["status"],
        message: json["message"],
        errorcode: json["errorcode"],
        emsg: json["emsg"],
        data: UserProfile.fromJson(json["data"]),
      );
}

class UserProfile {
  String image;
  String clientcode;
  String name;
  String email;
  String mobileno;
  String dpid;
  String dpName;
  String panNumber;
  String dob;
  String bankname;
  String bankaccno;
  String activesegments;
  String lastlogintime;
  String brokerid;
  bool poa;
  List<String> products;

  UserProfile({
    required this.image,
    required this.clientcode,
    required this.name,
    required this.email,
    required this.mobileno,
    required this.dpid,
    required this.dpName,
    required this.panNumber,
    required this.dob,
    required this.bankname,
    required this.bankaccno,
    required this.activesegments,
    required this.lastlogintime,
    required this.brokerid,
    required this.poa,
    required this.products,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        image: json["image"],
        clientcode: json["clientcode"],
        name: json["name"],
        email: json["email"],
        mobileno: json["mobileno"],
        dpid: json["dpid"],
        dpName: json["dpName"],
        panNumber: json["PanNumber"],
        dob: json["dob"],
        bankname: json["bankname"],
        bankaccno: json["bankaccno"],
        activesegments: json["activesegments"],
        lastlogintime: json["lastlogintime"],
        brokerid: json["brokerid"],
        poa: json["poa"],
        products: List<String>.from(json["products"].map((x) => x)),
      );
}
