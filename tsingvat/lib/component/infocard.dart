import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/util/GradientUtil.dart';

class InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            //decoration: BoxDecoration(color: Colors.grey[300]),
            width: 680.w,
            height: 400.h,
          ),
          Positioned(
            width: 600.w,
            height: 400.h,
            left: 40.w,
            child: Container(
              decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(30.w),
                  gradient: GradientUtil.warmFlame(angle: -45)),
            ),
          ),
          Positioned(
            width: 150.w,
            height: 150.w,
            left: 5.w,
            top: 50.h,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30.w),
              ),
              child: Image.asset(
                "assets/avatar_logo.png",
                //color: Colors.white,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            width: 350.w,
            left: 200.w,
            top: 60.h,
            child: Container(
              child: Text(
                "username1111111111111111111111",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
