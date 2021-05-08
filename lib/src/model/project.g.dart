// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    id: json['id'] as int,
    newsTitle: json['news_title'] as String,
    newsDescription: json['news_description'] as String,
    newsFeatureImage:
        (json['news_feature_image'] as List)?.map((e) => e as String)?.toList(),
    newsImage: (json['news_image'] as List)?.map((e) => e as String)?.toList(),
    newsType: json['news_type'] as String,
    newsStatus: json['news_status'] as String,
    newsCommentStatus: json['news_comment_status'] as int,
    newsPriceFrom: json['news_price_from'] as int,
    // newsPriceTo: json['news_price_to'] as int,
    newsLogo: (json['news_logo'] as List)?.map((e) => e as String)?.toList(),
    newsPriceMetersFrom: json['news_price_meters_from'] as int,
    newsPriceMetersTo: json['news_price_meters_to'] as int,
    newsInvestment: json['news_investment'] as int,
    newsBuildingDensity: json['news_building_density'] as int,
    newsLandArea: json['news_land_area'] as dynamic,
    user: json['news_author'] == null
        ? null
        : Users.fromJson(json['news_author'] as Map<String, dynamic>),
    newsProject: json['news_project'] as String,
    newsStreet: json['news_street'] as String,
    newsDistrict: json['news_district'] as String,
    newsWard: json['news_ward'],
    newsProvince: json['news_province'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    deletedAt: json['deleted_at'],
    countLike: json['count_like'] as int,
    countComment: json['count_comment'] as int,
    isLiked:  json['is_liked'] as bool,
    lat:  json['lat'] as double,
    lng:  json['lng'] as double
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'news_title': instance.newsTitle,
      'news_description': instance.newsDescription,
      'news_feature_image': instance.newsFeatureImage,
      'news_image': instance.newsImage,
      'news_type': instance.newsType,
      'news_status': instance.newsStatus,
      'news_comment_status': instance.newsCommentStatus,
      'news_price_from': instance.newsPriceFrom,
      'news_price_to': instance.newsPriceTo,
      'news_logo': instance.newsLogo,
      'news_price_meters_from': instance.newsPriceMetersFrom,
      'news_price_meters_to': instance.newsPriceMetersTo,
      'news_investment': instance.newsInvestment,
      'news_building_density': instance.newsBuildingDensity,
      'news_land_area': instance.newsLandArea,
      'user': instance.user?.toJson(),
      'news_project': instance.newsProject,
      'news_street': instance.newsStreet,
      'news_district': instance.newsDistrict,
      'news_ward': instance.newsWard,
      'news_province': instance.newsProvince,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'count_like': instance.countLike,
      'count_comment': instance.countComment,
      'is_liked': instance.isLiked,
      'lat': instance.lat,
      'lng': instance.lng,
    };
