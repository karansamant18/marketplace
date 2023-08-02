import 'dart:convert';

GetAdvisorByIdModel getAdvisorByIdModelFromJson(String str) =>
    GetAdvisorByIdModel.fromJson(json.decode(str));

class GetAdvisorByIdModel {
  int id;
  String blinkxAdvisorId;
  String blinkxAdvisorName;
  String blinkxNomenclature;
  String blinkxLoginId;
  String about;
  String picLoc;
  String advisorDesignation;
  String advisorTeam;
  int doc;
  int dom;
  int status;
  String tagline;
  dynamic performance;

  GetAdvisorByIdModel({
    required this.id,
    required this.blinkxAdvisorId,
    required this.blinkxAdvisorName,
    required this.blinkxNomenclature,
    required this.blinkxLoginId,
    required this.about,
    required this.picLoc,
    required this.advisorDesignation,
    required this.advisorTeam,
    required this.doc,
    required this.dom,
    required this.status,
    required this.tagline,
    this.performance,
  });

  factory GetAdvisorByIdModel.fromJson(Map<String, dynamic> json) =>
      GetAdvisorByIdModel(
        id: json["id"],
        blinkxAdvisorId: json["blinkxAdvisorId"],
        blinkxAdvisorName: json["blinkxAdvisorName"],
        blinkxNomenclature: json["blinkxNomenclature"],
        blinkxLoginId: json["blinkxLoginId"],
        about: json["about"],
        picLoc: json["picLoc"],
        advisorDesignation: json["advisorDesignation"],
        advisorTeam: json["advisorTeam"] ?? '',
        doc: json["doc"],
        dom: json["dom"],
        status: json["status"],
        tagline: json["tagline"],
        performance: json["performance"],
      );
}
