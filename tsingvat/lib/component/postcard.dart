import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/post.dart';

class PostCard extends StatelessWidget {
  String username;
  String time;
  String news;
  String imageurl;
  int imagenum;

  PostCard(Post post, {int num = 0}) {
    imagenum = num;
    username = post.username;
    time = DateTime.fromMillisecondsSinceEpoch(post.created).toString();
    news = post.content;
    imageurl = ConstUrl.postimageurl + '/${post.uuid}/0.png';
  }

  @override
  Widget build(BuildContext context) {
    // username = '发布者';
    // news =
    //     '具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容具体资讯内容';
    // time = '时间';
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
                    // CircleAvatar(
                    //   backgroundColor: Theme.of(context).primaryColorLight,
                    //   radius: 24,
                    // ),
                    ClipOval(
                        child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                      ),
                      child: Image.network(
                        "${ConstUrl.avatarimageurl}/${username}/avatar.png",
                        fit: BoxFit.cover,
                      ),
                    )),
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
              Container(
                child: imagenum > 0 ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                  child: CachedNetworkImage(
                    imageUrl: imageurl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpinKitThreeBounce(
                        color: Colors.blueAccent,
                        size: 10,
                      ),
                    ),
                  ),
                  //     Image.asset(
                  //   'assets/placeholder_image.png',
                  //   color: Colors.grey,
                  //   colorBlendMode: BlendMode.color,
                  //   fit: BoxFit.fitWidth,
                  // )
                ) : null,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Text(
                  news,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText1
                      .copyWith(height: 1.8),
                  textScaleFactor: 1,
                ),
              )
            ]),
      ),
    );
  }
}
