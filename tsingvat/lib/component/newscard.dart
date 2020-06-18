import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsCard extends StatelessWidget {
  String username;
  String time;
  String news;

  @override
  Widget build(BuildContext context) {
    username = '发布者';
    news = '具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容';
    time = '时间';
    return Container(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  radius: 24,
                ),
                Padding(padding: const EdgeInsets.all(8.0)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        username,
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      ),
                      Padding(padding: const EdgeInsets.all(1.0)),
                      Text(
                        time,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle2
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(icon: Icon(Icons.share), onPressed: () {})
              ],
            ),
          ),
          Padding(
            
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: 
            // CachedNetworkImage(imageUrl: 'assest/avatar_logo.png'),
            Image.asset('assets/placeholder_image.png', color: Colors.grey, colorBlendMode: BlendMode.color, fit: BoxFit.fitWidth,)
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(news, style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(height: 1.8), textScaleFactor: 1,),
          )
        ]),
      ),
    );
  }
}
