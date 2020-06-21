// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'errand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Errand _$ErrandFromJson(Map<String, dynamic> json) {
  return Errand()
    ..uuid = json['uuid'] as String
    ..username = json['username'] as String
    ..created = json['created'] as num
    ..content = json['content'] as String
    ..bonus = json['bonus'] as num
    ..fromAddr = json['fromAddr'] as String
    ..toAddr = json['toAddr'] as String
    ..sfromAddr = json['sfromAddr'] as String
    ..stoAddr = json['stoAddr'] as String
    ..ddlTime = json['ddlTime'] as num
    ..takeTime = json['takeTime'] as num
    ..finishTime = json['finishTime'] as num
    ..phone = json['phone'] as String
    ..details = json['details'] as String;
}

Map<String, dynamic> _$ErrandToJson(Errand instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'created': instance.created,
      'content': instance.content,
      'bonus': instance.bonus,
      'fromAddr': instance.fromAddr,
      'toAddr': instance.toAddr,
      'sfromAddr': instance.sfromAddr,
      'stoAddr': instance.stoAddr,
      'ddlTime': instance.ddlTime,
      'takeTime': instance.takeTime,
      'finishTime': instance.finishTime,
      'phone': instance.phone,
      'details': instance.details,
    };
