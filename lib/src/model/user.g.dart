// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UserFromJson(Map<String, dynamic> json) {
  return Users(
    id: json['id'] as int,
    email: json['email'] as String,
    passwords: json['passwords'] as String,
    phone: json['phone'] as String,
    urlAvata: json['url_avata'] as String,
    urlCoverImage: json['url_cover_image'] as String,
    username: json['username'] as String,
    personalInfo: json['personal_infor'] as String,
    firstname: json['firstname'] as dynamic,
    lastname: json['lastname'] as dynamic,
    idTokenFacebook: json['id_token_faceboook'] as String,
    idTokenGoogle: json['id_token_google'] as String,
    birthDay: json['birth_date'] as String,
    // job: json['job_id'] == null
    //     ? null
    //     : Job.fromJson(json['job_id'] as Map<String, dynamic>),
  );
}
Map<String, dynamic> _$UserToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'passwords': instance.passwords,
      'phone': instance.phone,
      'url_avata': instance.urlAvata,
      'url_cover_image': instance.urlCoverImage,
      'username': instance.username,
      'personal_infor': instance.personalInfo,
      'id_token_faceboook': instance.idTokenFacebook,
      'id_token_google': instance.idTokenGoogle,
      'birth_date': instance.birthDay,
      'job_id': instance.job?.toJson(),
    };
