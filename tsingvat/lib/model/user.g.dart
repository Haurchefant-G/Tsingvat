// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..username = json['username'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as num
    ..password = json['password'] as String
    ..nickname = json['nickname'] as String
    ..signature = json['signature'] as String
    ..avatar = json['avatar'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'nickname': instance.nickname,
      'signature': instance.signature,
      'avatar': instance.avatar,
    };
