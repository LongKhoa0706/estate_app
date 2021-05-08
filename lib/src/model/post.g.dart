// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    user: json['user'] == null
        ? null
        : Users.fromJson(json['post_author'] as Map<String, dynamic>),
    postContent: json['post_content'] as String,
    postImage: (json['post_image'] as List)?.map((e) => e as String)?.toList(),
    postStatus: json['post_status'] as String,
    postCommentStatus: json['post_comment_status'] as int,
    updatedAt: json['updated_at'] as String,
    createdAt: json['created_at'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'postContent': instance.postContent,
      'postImage': instance.postImage,
      'postStatus': instance.postStatus,
      'postCommentStatus': instance.postCommentStatus,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'id': instance.id,
    };
