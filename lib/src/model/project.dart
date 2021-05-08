import 'dart:io';
import 'package:estate_app/src/model/users.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
part 'project.g.dart';
@JsonSerializable(explicitToJson: true)
class Project {
  int id;
  String newsTitle;
  String newsDescription;
  List<String> newsFeatureImage;
  List<String> newsImage;
  String newsType;
  String newsStatus;
  int newsCommentStatus;
  int newsPriceFrom;
  dynamic newsPriceTo;
  List<String> newsLogo;
  int newsPriceMetersFrom;
  int newsPriceMetersTo;
  int newsInvestment;
  int newsBuildingDensity;
  dynamic newsLandArea;
  Users user;
  String newsProject;
  String newsStreet;
  String newsDistrict;
  dynamic newsWard;
  String newsProvince;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int countLike;
  int countComment;
  bool isLiked;
  double lat;
  double lng;

  Project(
      {this.id,
        this.newsTitle,
        this.newsDescription,
        this.newsFeatureImage,
        this.newsImage,
        this.newsType,
        this.newsStatus,
        this.newsCommentStatus,
        this.newsPriceFrom,
        this.newsPriceTo,
        this.newsLogo,
        this.newsPriceMetersFrom,
        this.newsPriceMetersTo,
        this.newsInvestment,
        this.newsBuildingDensity,
        this.newsLandArea,
        this.user,
        this.newsProject,
        this.newsStreet,
        this.newsDistrict,
        this.newsWard,
        this.newsProvince,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.countLike,
        this.countComment,
        this.isLiked,
        this.lat,
        this.lng});

 factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
