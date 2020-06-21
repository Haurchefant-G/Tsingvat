import 'package:json_annotation/json_annotation.dart';

part 'errand.g.dart';
@JsonSerializable()
class Errand {
    Errand();

    String uuid;
    String username;
    num created;
    String content;
    num bonus;
    String fromAddr;
    String toAddr;
    String sfromAddr;
    String stoAddr;
    num ddlTime;
    num takeTime;
    num finishTime;
    String phone;
    String details;
    
    factory Errand.fromJson(Map<String,dynamic> json) => _$ErrandFromJson(json);
    Map<String, dynamic> toJson() => _$ErrandToJson(this);
}