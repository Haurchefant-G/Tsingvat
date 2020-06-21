import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DealDetail extends StatefulWidget {
  @override
  _DealDetailState createState() => _DealDetailState();
}

class _DealDetailState extends State<DealDetail> {
  String name;
  double price;
  String detail;

  @override
  Widget build(BuildContext context) {
    name = '商品名称';
    price = 0;
    detail =
        '商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本商品介绍测试文本';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(350),
        child: AppBar(
          //backgroundColor: Colors.transparent,
          flexibleSpace: Image(
            image: AssetImage(
              "assets/placeholder_image.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.star_border,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              CachedNetworkImage(imageUrl: 'img'),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: Theme.of(context).primaryTextTheme.headline4,
                    ),
                    Text(
                      "￥" + price.toString(),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline5
                          .copyWith(color: Colors.red[400]),
                    ),
                    Text(
                      detail,
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            radius: 12,
                          ),
                        ),
                        Text(
                          "用户名",
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
        )
      ]),
    );
  }
}
