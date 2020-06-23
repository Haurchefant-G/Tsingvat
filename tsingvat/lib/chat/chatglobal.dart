import 'dart:convert';

import 'package:tsingvat/model/conversation.dart';
import 'package:tsingvat/model/me.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';

class ChatGlobal {
  static Conversation conversation = Conversation();
  static List chatusers;
  static Profile me = Profile();
  static Future init() async {
    chatusers = jsonDecode(await SharedPreferenceUtil.getString("chatlist"));
    Conversation.initMockConversations(chatusers);
  }

  static Future initMe() async {
    me.avatar = await SharedPreferenceUtil.getString("avatar");
    me.name = await SharedPreferenceUtil.getString("username");

  }
}
