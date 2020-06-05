import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'newTaskPage.dart';
import 'component/taskcard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _counter = 0;
  TabController _tabController;
  List tabs = ["跑腿", "交易", "资讯", "我的"];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    //_tabController.addListener(() { })
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabs(int tabindex) {
    _tabController.animateTo(tabindex,
        duration: const Duration(milliseconds: 300));
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print("刷新结束");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: false,
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: CraneAppBar(
                      tabController: _tabController,
                      tabHandler: _handleTabs,
                      tabs: tabs))
            ];
          },
          body: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: TabBarView(
                  //physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: tabs
                      .map((e) => Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          //padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors
                                  .white70, //Theme.of(context).backgroundColor,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          child: RefreshIndicator(
                              child:
                                  ListView.builder(itemBuilder: (context, i) {
                                // if (i.isOdd) return new Divider();
                                // final index = i ~/ 2;
                                // return ListTile(
                                //   title: Text(i.toString()),
                                // );
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: TaskCard(),
                                );
                              }),
                              // SliverFixedExtentList(
                              //   itemExtent: 50.0,
                              //   delegate: SliverChildBuilderDelegate(
                              //     (context, index) => ListTile(
                              //       title: Text("Item $index"),
                              //     ),
                              //     childCount: 30,
                              //   ),
                              // ),
                              //Text(e),
                              onRefresh: _refresh)))
                      .toList()))),
      // CustomScrollView(slivers: <Widget>[
      //   SliverAppBar(
      //     floating: false,
      //     pinned: true,
      //     //expandedHeight:96,
      //     flexibleSpace: CraneAppBar(
      //         tabController: _tabController,
      //         tabHandler: _handleTabs,
      //         tabs: tabs),
      //   ),
      //   TabBarView(
      //       controller: _tabController,
      //       children: tabs.map((e) => Text(e)).toList())
      // ]),
      floatingActionButton: OpenContainer(
        //transitionDuration: const Duration(milliseconds: 2000),
        closedColor: Theme.of(context).primaryColorDark,
        transitionType: ContainerTransitionType.fade,
        closedBuilder: (BuildContext context, VoidCallback _) {
          return FloatingActionButton(onPressed: null, backgroundColor: Theme.of(context).primaryColorDark,child: Icon(Icons.add, size: 30,),);
        },
        openBuilder: (BuildContext context, VoidCallback _) {
          return newTaskPage();
        },
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(56 / 2),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "loginPage");
                }),
            SizedBox(),
            IconButton(icon: Icon(Icons.bubble_chart), onPressed: null)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}

class CraneAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(int) tabHandler;
  final TabController tabController;
  final List tabs;

  const CraneAppBar({Key key, this.tabHandler, this.tabController, this.tabs})
      : super(key: key);

  @override
  _CraneAppBarState createState() => _CraneAppBarState();

  @override
  Size get preferredSize {
    // for (final String item in tabs) {
    //   if (item is Widget) {
    //     final Tab tab = Tab(text:item);
    //     if ((tab.text != null || tab.child != null) && tab.icon != null)
    //       return Size.fromHeight(_kTextAndIconTabHeight + indicatorWeight);
    //   }
    // }
    return Size.fromHeight(46.0 + 2.0);
  }
}

class _CraneAppBarState extends State<CraneAppBar> {
  @override
  Widget build(BuildContext context) {
    //final isDesktop = isDisplayDesktop(context);
    //final isSmallDesktop = isDisplaySmallDesktop(context);
    //final textScaleFactor = GalleryOptions.of(context).textScaleFactor(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            //horizontal:
            //isDesktop && !isSmallDesktop ? appPaddingLarge : appPaddingSmall,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const ExcludeSemantics(
            //   child: FadeInImagePlaceholder(
            //     image: AssetImage(
            //       'assets/placeholder_image.png',
            //     ),
            //     placeholder: SizedBox(
            //       width: 40,
            //       height: 60,
            //     ),
            //     width: 40,
            //     height: 60,
            //   ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 24),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                  ),
                  child: TabBar(
                    // indicator: BorderTabIndicator(
                    //   indicatorHeight: isDesktop ? 28 : 32,
                    //   textScaleFactor: textScaleFactor,
                    // ),
                    controller: widget.tabController,
                    labelPadding:
                        // isDesktop ?
                        const EdgeInsets.symmetric(horizontal: 32),
                    // : EdgeInsets.zero,
                    isScrollable: false, // left-align tabs on desktop
                    labelStyle: Theme.of(context).textTheme.button,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white.withOpacity(.6),
                    onTap: (index) => widget.tabController.animateTo(
                      index,
                      duration: const Duration(milliseconds: 300),
                    ),
                    tabs: widget.tabs
                        .map((e) => Tab(
                              text: e,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
