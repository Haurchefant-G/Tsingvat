import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';
@JsonSerializable()
class Post {
    Post();

    String uuid;
    String username;
    num created;
    String content;
    
    factory Post.fromJson(Map<String,dynamic> json) => _$PostFromJson(json);
    Map<String, dynamic> toJson() => _$PostToJson(this);
}