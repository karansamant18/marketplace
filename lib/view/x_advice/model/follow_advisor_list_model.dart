import 'dart:convert';

List<FollowAdvisorList> getFollowAdvisorList(String str) =>
    List<FollowAdvisorList>.from(
        json.decode(str).map((x) => FollowAdvisorList.fromJson(x)));

class FollowAdvisorList {
  int? id;
  int? advisorId;
  int? userId;
  int? followStatus;

  FollowAdvisorList({
    this.id,
    this.advisorId,
    this.userId,
    this.followStatus,
  });

  FollowAdvisorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advisorId = json['advisorId'];
    userId = json['userId'];
    followStatus = json['followStatus'] ?? 1;
  }
}
