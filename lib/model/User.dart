import 'package:json_annotation/json_annotation.dart';

// https://www.jianshu.com/p/b307a377c5e8
// 生成.g.dart文件在terminal中运行 > flutter packages pub run build_runner build
//part 'User.g.dart';

@JsonSerializable()
class User {
  String login;
  int id;
  String avatarUrl;
  String url;
  String username;
  String email;
  int followers;
  int following;
//  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);


//
//  Map<String, dynamic> toJson() => _$UserToJson(this);
  User(this.login,
      this.id,
      this.avatarUrl,
      this.username,
      this.email,
      this.followers,
      this.following);

  // 命名构造函数
  User.empty();

}
