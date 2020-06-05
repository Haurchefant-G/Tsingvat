import 'package:flutter/material.dart';
import 'package:tsingvat/loginPage.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:
          (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: Login(),
        );
      },
      transitionDuration: Duration(seconds: 2))
      );
    });
    return Material(
      child: Stack(alignment: Alignment.center, children: [
        Hero(
          tag: 'tsingvat',
          child: Text(
            'TsingVat',
            style: Theme.of(context)
                .primaryTextTheme
                .headline1
                .copyWith(fontSize: 80),
          ),
        )
      ]),
    );
  }
}
