class BlinkxUserProfileModel {
  String? status;
  BlinkxUserProfile? data;

  BlinkxUserProfileModel({this.status, this.data});

  BlinkxUserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? BlinkxUserProfile.fromJson(json['data']) : null;
  }
}

class BlinkxUserProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? doc;
  bool? isActive;
  String? role;

  BlinkxUserProfile(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNo,
      this.doc,
      this.isActive,
      this.role});

  BlinkxUserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNo = json['phoneNo'];
    doc = json['doc'];
    isActive = json['isActive'];
    role = json['role'];
  }
}
