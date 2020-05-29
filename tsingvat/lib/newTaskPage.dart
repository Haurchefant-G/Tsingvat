import 'package:flutter/material.dart';

class newTaskPage extends StatefulWidget {
  @override
  _newTaskPageState createState() => _newTaskPageState();
}

class _newTaskPageState extends State<newTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.home), onPressed: null)
      //   ],
      //   backgroundColor: Theme.of(context).secondaryHeaderColor,
      //   //bottom: TabBar(tabs: [Tab(child: Text("123"))]),
      //   flexibleSpace: FlexibleSpaceBar(title: Text("123")),
      // ),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          //title: Text("title"),
          floating: false,
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(title: Text("发布任务")),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text("Item $index"),
            ),
            childCount: 30,
          ),
        ),
      ]),
    );
  }
}
