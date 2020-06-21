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
    ..price = json['price'] as num
    ..taker = json['taker'] as String
    ..takeTime = json['takeTime'] as num
    ..details = json['details'] as String
    ..phone = json['phone'] as String;
}

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'created': instance.created,
      'content': instance.content,
      'price': instance.price,
      'taker': instance.taker,
      'takeTime': instance.takeTime,
      'details': instance.details,
      'phone': instance.phone,
    };
