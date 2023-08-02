class IsJmClientModel {
  IsJmClientModelDetails? data;

  IsJmClientModel({this.data});

  IsJmClientModel.fromJson(Map<String, dynamic> json) {
    data = json['Details'] != null
        ? IsJmClientModelDetails.fromJson(json['Details'])
        : null;
  }
}

class IsJmClientModelDetails {
  String? firstName;
  String? lastName;
  String? clientId;
  String? emailAddress;

  IsJmClientModelDetails(
      {this.firstName, this.lastName, this.clientId, this.emailAddress});

  IsJmClientModelDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    clientId = json['ClientId'];
    emailAddress = json['EmailAddress'];
  }
}
