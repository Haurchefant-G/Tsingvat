import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsingvat/chat/chat_detail_page.dart';
import 'package:tsingvat/const/const_url.dart';
import 'package:tsingvat/model/deal.dart';

class DealDetail extends StatefulWidget {
  Deal deal;

  DealDetail(Deal deal) {
    this.deal = deal;
  }

  @override
  _DealDetailState createState() => _DealDetailState();
}

class _DealDetailState extends State<DealDetail> {
  String name;
  double price;
  String detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(350),
        child: AppBar(
          //backgroundColor: Colors.transparent,
          flexibleSpace: 
          Container(
            height: 400,
            child: CachedNetworkImage(imageUrl: '${ConstUrl.dealimageurl}/${widget.deal.uuid}/0.png',
            fit: BoxFit.cover,

            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpinKitThreeBounce(color: Colors.blueAccent, size: 10,),
            )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context){
                print('username:${widget.deal.username}');
                return ChatDetailPage(widget.deal.username);
              })
          );
        },
        backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(
          Icons.chat,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              //CachedNetworkImage(imageUrl: 'img'),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget.deal.content}',
                      style: Theme.of(context).primaryTextTheme.headline4,
                    ),
                    Text(
                      "￥${widget.deal.price.toString()}",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline5
                          .copyWith(color: Colors.red[400]),
                    ),
                    Text(
                      '${widget.deal.details}',
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child:
                              ClipOval(
                                  child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                            ),
                            child: Image.network(
                              "${ConstUrl.avatarimageurl}/${widget.deal.username}/avatar.png",
                              fit: BoxFit.cover,
                            ),
                          )),
                        ),
                        Text(
                          '${widget.deal.username}',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child:
                          Icon(Icons.phone, size: 36,)
                        ),
                        Text(
                          '${widget.deal.phone}',
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
