import 'package:json_annotation/json_annotation.dart';

part 'errand.g.dart';
@JsonSerializable()
class Errand {
    Errand();

    
    factory Errand.fromJson(Map<String,dynamic> json) => _$ErrandFromJson(json);
    Map<String, dynamic> toJson() => _$ErrandToJson(this);
}