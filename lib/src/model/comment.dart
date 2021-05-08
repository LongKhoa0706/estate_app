import 'package:estate_app/src/model/users.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';
@JsonSerializable(explicitToJson: true)
class Comment {
  int id;
  Users user;
  String commentContent;
  int commentLevel;
  dynamic commentId;
  int newsId;
  String createdAt;
  String updatedAt;
  int countLike;
  int countComment;

  Comment(
      {this.id,
        this.user,
        this.commentContent,
        this.commentLevel,
        this.commentId,
        this.newsId,
        this.createdAt,
        this.updatedAt,
        this.countLike,
        this.countComment});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

