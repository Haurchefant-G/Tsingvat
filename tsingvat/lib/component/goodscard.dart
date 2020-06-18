import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GoodsCard extends StatelessWidget {
  String name;
  double price;
  @override
  Widget build(BuildContext context) {
    name = '商品名称';
    price = 0;
    return Container(
      // child: Card(
        child: Column(
          children: <Widget>[
            CachedNetworkImage(imageUrl: 'img'),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, style: Theme.of(context).primaryTextTheme.subtitle1,),
                  Text("￥" + price.toString(), style: Theme.of(context).primaryTextTheme.subtitle2.copyWith(color: Colors.red[400]),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColorLight,
                          radius: 12,
                        ),
                      ),
                      Text("用户名", style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Colors.grey),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      // ),
    );
  }
}

