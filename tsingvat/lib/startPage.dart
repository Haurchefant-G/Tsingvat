import 'package:flutter/material.dart';
import 'package:tsingvat/HomePage.dart';
import 'package:tsingvat/loginPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';

class StartPage extends StatelessWidget {
  init(BuildContext context) async {
    String password = await SharedPreferenceUtil.getString('password');
    print(password);
    if (password != null) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, 'homePage');
        // Navigator.pushReplacement(
        //     context,
        //     PageRouteBuilder(
        //         pageBuilder: (BuildContext context, Animation animation,
        //             Animation secondaryAnimation) {
        //           return FadeTransition(
        //             opacity: animation,
        //             child: HomePage(),
        //           );
        //         },
        //         transitionDuration: Duration(seconds: 1)));
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: Login(),
                  );
                },
                transitionDuration: Duration(seconds: 2)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
    init(context);
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
