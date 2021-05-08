// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as int,
    user: json['user_id'] == null
        ? null
        : Users.fromJson(json['user_id'] as Map<String, dynamic>),
    commentContent: json['comment_content'] as String,
    commentLevel: json['comment_level'] as int,
    commentId: json['comment_id'],
    newsId: json['news_id'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    countLike: json['count_like'] as int,
    countComment: json['count_comment'] as int,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'commentContent': instance.commentContent,
      'commentLevel': instance.commentLevel,
      'commentId': instance.commentId,
      'newsId': instance.newsId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'countLike': instance.countLike,
      'countComment': instance.countComment,
    };
