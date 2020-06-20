import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsingvat/util/GradientUtil.dart';

class TakedTaskCard extends StatefulWidget {
  @override
  _TakedTaskCardState createState() => _TakedTaskCardState();
}

class _TakedTaskCardState extends State<TakedTaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            //decoration: BoxDecoration(color: Colors.grey[300]),
            width: 750.w,
            height: 500.w,
          ),
          Positioned(
            width: 600.w,
            height: 400.w,
            //left: -30.w,
            top: 50.w,
            child: Container(
              decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(30.w)),
                  gradient: GradientUtil.warmFlame(angle: -45)),
            ),
          ),
          Positioned(
            width: 100.w,
            height: 100.w,
            left: 50.w,
            //top: 50.h,
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
            top: 120.w,
            left: 50.w,
            width: 600.w,
            child: DefaultTextStyle(
              style: Theme.of(context).primaryTextTheme.headline6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 500.w,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("时间"),
                            Text("报酬"),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(15.w)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("起始地点"),
                            Icon(Icons.arrow_forward),
                            Text("送达地点"),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(15.w)),
                      ],
                    ),
                  ),
                  Container(
                    width: 650.w,
                    height: 150.w,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.w),
                      color: Colors.grey,
                    ),
                    //gradient: GradientUtil.warmFlame(angle: -45)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.description),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {},
                        ),
                        IconButton(icon: Icon(Icons.chat), onPressed: () {}),
                        IconButton(icon: Icon(Icons.done), onPressed: () {}),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
