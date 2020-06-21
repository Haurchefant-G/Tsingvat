import 'package:json_annotation/json_annotation.dart';

part 'deal.g.dart';
@JsonSerializable()
class Deal {
    Deal();

    String uuid;
    String username;
    num created;
    String content;
    num price;
    String taker;
    num takeTime;
    String details;
    String phone;
    
    factory Deal.fromJson(Map<String,dynamic> json) => _$DealFromJson(json);
    Map<String, dynamic> toJson() => _$DealToJson(this);
}