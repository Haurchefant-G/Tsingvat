import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget content;
  CustomDialog({this.title, this.content, this.actions});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}
