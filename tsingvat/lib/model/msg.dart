import 'package:json_annotation/json_annotation.dart';

part 'msg.g.dart';
@JsonSerializable()
class Msg {
    Msg();

    String uuid;
    String sender;
    String receiver;
    num created;
    String content;
    num type;
    bool sent;
    
    factory Msg.fromJson(Map<String,dynamic> json) => _$MsgFromJson(json);
    Map<String, dynamic> toJson() => _$MsgToJson(this);
}