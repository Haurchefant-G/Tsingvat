import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/deal.dart';

class DealCard extends StatelessWidget {
  String uuid;
  String name;
  double price;
  String content;
  DealCard(Deal deal) {
    uuid = deal.uuid;
    name = deal.username;
    price = deal.price;
    content = deal.content;
  }

  @override
  Widget build(BuildContext context) {
    // name = '商品名称';
    // price = 0;
    return Material(
      elevation: 3,
      // child: Card(
      child: Column(
        children: <Widget>[
          CachedNetworkImage(imageUrl: '${ConstUrl.dealimageurl}/${uuid}/0.png',
          fit: BoxFit.cover,

          placeholder: (context, url) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpinKitThreeBounce(color: Colors.blueAccent, size: 10,),
          ),
          ),
          // Image.network("${ConstUrl.dealimageurl}/${uuid}/0.png"),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // CachedNetworkImage(
                //     imageUrl: "${ConstUrl.dealimageurl}/${uuid}/0.png"),
                // Image.network("${ConstUrl.dealimageurl}/${uuid}/0.png"),
                Text(
                  content ?? "物品名",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                ),
                Text(
                  "￥${price?.toString()}",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle2
                      .copyWith(color: Colors.red[400]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                      child:
                      ClipOval(child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        child: Image.network(
                              "${ConstUrl.avatarimageurl}/${name}/avatar.png", fit: BoxFit.cover,),
                      )),
                    ),
                    Text(
                      name ?? "用户名",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                    )
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
