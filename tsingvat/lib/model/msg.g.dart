// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Msg _$MsgFromJson(Map<String, dynamic> json) {
  return Msg()
    ..uuid = json['uuid'] as String
    ..sender = json['sender'] as String
    ..receiver = json['receiver'] as String
    ..created = json['created'] as num
    ..content = json['content'] as String
    ..type = json['type'] as num
    ..sent = json['sent'] as bool;
}

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'created': instance.created,
      'content': instance.content,
      'type': instance.type,
      'sent': instance.sent,
    };
