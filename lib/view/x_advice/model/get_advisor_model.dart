import 'dart:convert';

List<GetAdvisorListModel> getAdvisorModelFromJson(String str) =>
    List<GetAdvisorListModel>.from(
        json.decode(str).map((x) => GetAdvisorListModel.fromJson(x)));

class GetAdvisorListModel {
  int id;
  String blinkxAdvisorId;
  String blinkxAdvisorName;
  String blinkxNomenclature;
  String blinkxLoginId;
  String about;
  String picLoc;
  String advisorDesignation;
  String? advisorTeam;
  int doc;
  int dom;
  int status;
  bool? isOpen;
  String tagline;
  double? performance;
  double? callsTotal;
  double? callsHit;
  double? callsMiss;

  GetAdvisorListModel({
    required this.id,
    required this.blinkxAdvisorId,
    required this.blinkxAdvisorName,
    required this.blinkxNomenclature,
    required this.blinkxLoginId,
    required this.about,
    required this.picLoc,
    required this.advisorDesignation,
    this.advisorTeam,
    required this.doc,
    required this.dom,
    required this.status,
    this.isOpen,
    required this.tagline,
    this.performance,
    this.callsTotal,
    this.callsHit,
    this.callsMiss,
  });

  factory GetAdvisorListModel.fromJson(Map<String, dynamic> json) =>
      GetAdvisorListModel(
        id: json["id"],
        blinkxAdvisorId: json["blinkxAdvisorId"],
        blinkxAdvisorName: json["blinkxAdvisorName"],
        blinkxNomenclature: json["blinkxNomenclature"],
        blinkxLoginId: json["blinkxLoginId"],
        about: json["about"],
        picLoc: json["picLoc"],
        advisorDesignation: json["advisorDesignation"],
        advisorTeam: json["advisorTeam"],
        doc: json["doc"],
        dom: json["dom"],
        status: json["status"],
        tagline: json["tagline"],
        performance: json["performance"] ?? 0,
        callsTotal: json["callsTotal"] ?? 0,
        callsHit: json["callsHit"] ?? 0,
        callsMiss: json["callsMiss"] ?? 0,
        isOpen: false,
      );
}
