// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..uuid = json['uuid'] as String
    ..username = json['username'] as String
    ..created = json['created'] as num
    ..content = json['content'] as String;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'created': instance.created,
      'content': instance.content,
    };
