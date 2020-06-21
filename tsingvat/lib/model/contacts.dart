import 'package:flutter/material.dart';

class Contact{
  String avatar;
  String name;
  String nameIndex;
  VoidCallback onPressed;

  bool isAvatarFromNet(){
    if(this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }

  Contact({
    this.avatar,
    this.name,
    this.nameIndex,
    this.onPressed,
  }): assert(avatar != null),
        assert(name != null);

  static  List<Contact> contacts =[
    new Contact(
      avatar: 'http://121.199.66.17:8800/images/post/22d54a0b-9507-4d5b-bb08-a84293bbef55/1.png',
      name: '张小健',
      nameIndex: 'Z',
    ),
  ];
}

class ContactEventItem{
  String avatar;
  String name;
  VoidCallback onPressed;

  ContactEventItem({
    @required this.avatar,
    @required this.name,
    @required this.onPressed,
  });
}