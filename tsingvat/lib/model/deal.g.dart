// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deal _$DealFromJson(Map<String, dynamic> json) {
  return Deal()
    ..uuid = json['uuid'] as String
    ..username = json['username'] as String
    ..created = json['created'] as num
    ..content = json['content'] as String
    ..ddl = json['ddl'] as num
    ..price = json['price'] as num
    ..taker = json['taker'] as String
    ..takeTime = json['takeTime'] as num;
}

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'created': instance.created,
      'content': instance.content,
      'ddl': instance.ddl,
      'price': instance.price,
      'taker': instance.taker,
      'takeTime': instance.takeTime,
    };
