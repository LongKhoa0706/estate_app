import 'package:estate_app/src/model/job.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
@JsonSerializable()
class Users {
  int id;
  String email;
  String passwords;
  String phone;
  String urlAvata;
  String firstname;
  String lastname;
  String urlCoverImage;
  String username;
  String personalInfo;
  String idTokenFacebook;
  String idTokenGoogle;
  String birthDay;
  Job job;

  Users(
      { this.id,
        this.email,
        this.passwords,
        this.phone,
        this.urlAvata,
        this.urlCoverImage,
        this.username,
        this.personalInfo,
        this.idTokenFacebook,
        this.idTokenGoogle,
        this.birthDay,
        this.firstname,
        this.lastname,
        this.job});

 factory Users.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}