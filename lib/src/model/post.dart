import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';
@JsonSerializable(explicitToJson: true)
class Post {
  Users user;
  String postContent;
  List<String> postImage;
  String postStatus;
  int postCommentStatus;
  String updatedAt;
  String createdAt;
  int id;
  int countLike;
  int countComment;
  dynamic isLiked;

  Post(
      {this.user,
        this.postContent,
        this.postImage,
        this.postStatus,
        this.postCommentStatus,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.countLike,
        this.countComment,
        this.isLiked});

  Post.fromJson(Map<String, dynamic> json) {
    user = json['post_author'] != null
        ? new Users.fromJson(json['post_author'])
        : null;
    postContent = json['post_content'];
    postImage = json['post_image'].cast<String>();
    postStatus = json['post_status'];
    postCommentStatus = json['post_comment_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    isLiked = json['is_liked'];
    countLike = json['count_like'];
    countComment = json['count_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['post_author'] = this.user.toJson();
    }
    data['post_content'] = this.postContent;
    data['post_image'] = this.postImage;
    data['post_status'] = this.postStatus;
    data['post_comment_status'] = this.postCommentStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['is_liked'] = this.isLiked;
    data['count_like'] = this.countLike;
    data['count_comment'] = this.countComment;
    return data;
  }
}

