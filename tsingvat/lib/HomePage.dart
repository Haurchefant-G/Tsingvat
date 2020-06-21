import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:tsingvat/component/infocard.dart';
import 'package:tsingvat/page/newPostPage.dart';
import 'package:tsingvat/page/newErrandPage.dart';
import 'package:tsingvat/page/newDealPage.dart';
import 'package:tsingvat/component/errandcard.dart';
import 'package:tsingvat/tabPage/DealPage.dart';
import 'package:tsingvat/tabPage/PostPage.dart';
import 'package:tsingvat/tabPage/InfoPage.dart';
import 'package:tsingvat/tabPage/ErrandPage.dart';
import 'package:tsingvat/util/GradientUtil.dart';
import 'package:tsingvat/util/SharedPreferenceUtil.dart';

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
  List tabs = [" 跑腿 ", " 交易 ", " 资讯 ", " 我的 "];
  AnimationController _fabController;
  Animation<double> _expandAnimation;
  bool _showFab = true;
  bool _fabTappable = true;

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
    _tabController.addListener(() {
      _handleTabs(_tabController.index);
    });
    _fabController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    // _expandAnimation =
    //     Tween<double>(begin: 200.0, end: 0.0).animate(_expandController)
    //       ..addListener(() {
    //         setState(() {});
    //       });
    //_tabController.addListener(() { })
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  void _handleTabs(int tabindex) {
    // _tabController.animateTo(tabindex,
    //     duration: const Duration(milliseconds: 300));
    print(_tabController.index);
    if (_tabController.index == 3) {
      setState(() {
        _showFab = false;
        _fabController.forward();
      });
    } else {
      setState(() {
        _showFab = true;
        _fabController.reverse();
      });
    }
    // if (_tabController.index != 0) {
    //   _expandController.forward();
    // } else {
    //   _expandController.reverse();
    // }
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
      // appBar:HomeAppBar(
      //                 tabController: _tabController,
      //                 tabHandler: _handleTabs,
      //                 tabs: tabs),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                automaticallyImplyLeading: false,
                floating: false,
                pinned: true,
                expandedHeight: 0, //_expandAnimation.value,
                flexibleSpace: HomeAppBar(
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
              children: <Widget>[
                ErrandPage(),
                // Container(
                //     padding: EdgeInsets.only(left: 10, right: 10),
                //     margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //     //padding: EdgeInsets.all(16),
                //     decoration: BoxDecoration(
                //         color: Colors
                //             .white70, //Theme.of(context).backgroundColor,
                //         borderRadius:
                //             BorderRadius.vertical(top: Radius.circular(15))),
                //     child: RefreshIndicator(
                //         child: ListView.builder(itemBuilder: (context, i) {
                //           return Padding(
                //             padding: const EdgeInsets.only(bottom: 10),
                //             child: GoodsCard(),
                //           );
                //         }),
                //         onRefresh: _refresh)),
                DealPage(),
                PostPage(),
                InfoPage()
              ],
            )),
      ),
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
      floatingActionButton:
          // _showFab
          //     ? OpenContainer(
          //         //transitionDuration: const Duration(milliseconds: 2000),
          //         closedColor: Theme.of(context).primaryColorDark,
          //         transitionType: ContainerTransitionType.fade,
          //         closedBuilder: (BuildContext context, VoidCallback _) {
          //           return FloatingActionButton(
          //             onPressed: null,
          //             backgroundColor: Theme.of(context).primaryColorDark,
          //             child: Icon(
          //               Icons.add,
          //               size: 30,
          //             ),
          //           );
          //         },
          //         tappable: _fabTappable,
          //         openBuilder: (BuildContext context, VoidCallback _) {
          //           switch (_tabController.index) {
          //             case 0:
          //               return newTaskPage();
          //             case 1:
          //               return newGoodsPage();
          //             default:
          //               return newTaskPage();
          //           }
          //         },
          //         closedElevation: 6.0,
          //         closedShape: const RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(56 / 2),
          //           ),
          //         ),
          //       )
          //     : null,
          ScaleTransition(
        alignment: Alignment.center,
        scale: Tween(begin: 1.0, end: 0.0).animate(_fabController),
        child: OpenContainer(
          //transitionDuration: const Duration(milliseconds: 2000),
          closedColor: Theme.of(context).primaryColorDark,
          transitionType: ContainerTransitionType.fade,
          closedBuilder: (BuildContext context, VoidCallback _) {
            return FloatingActionButton(
              onPressed: null,
              backgroundColor: Theme.of(context).primaryColorDark,
              child: Icon(
                Icons.add,
                size: 30,
              ),
            );
          },
          openBuilder: (BuildContext context, VoidCallback _) {
            switch (_tabController.index) {
              case 0:
                return newErrandPage();
              case 1:
                return newDealPage();
              case 2:
                return newPostPage();
              default:
                return newErrandPage();
            }
          },
          closedElevation: 6.0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(56 / 2),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: null,
        //_showFab ? CircularNotchedRectangle() : null,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  SharedPreferenceUtil.remove('password');
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

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(int) tabHandler;
  final TabController tabController;
  final List tabs;

  const HomeAppBar({Key key, this.tabHandler, this.tabController, this.tabs})
      : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

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

class _HomeAppBarState extends State<HomeAppBar> {
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
                padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                  ),
                  child: TabBar(
                    indicator:
                        // BoxDecoration(
                        //   border: Border.all(width:2),
                        //   borderRadius: BorderRadius.circular(100),
                        //   gradient: GradientUtil.warmFlame()

                        // )
                        // ,
                        // indicatorSize: TabBarIndicatorSize.label,
                        BorderTabIndicator(
                      indicatorHeight: 32,
                      textScaleFactor: 1,
                    ),
                    controller: widget.tabController,
                    // labelPadding:
                    //     // isDesktop ?
                    //     const EdgeInsets.symmetric(horizontal: 20),
                    // : EdgeInsets.zero,
                    isScrollable: false, // left-align tabs on desktop
                    labelStyle: Theme.of(context).primaryTextTheme.headline6,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelStyle:
                        Theme.of(context).primaryTextTheme.button,
                    unselectedLabelColor: Theme.of(context).hintColor,
                    onTap: (index) {
                      // widget.tabController.animateTo(
                      //   index,
                      //   duration: const Duration(milliseconds: 300),
                      // );
                      //widget.tabHandler(index);
                      //widget.tabHandler(index);
                    },

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

class BorderTabIndicator extends Decoration {
  BorderTabIndicator({this.indicatorHeight, this.textScaleFactor}) : super();

  final double indicatorHeight;
  final double textScaleFactor;

  @override
  _BorderPainter createBoxPainter([VoidCallback onChanged]) {
    return _BorderPainter(this, indicatorHeight, textScaleFactor, onChanged);
  }
}

class _BorderPainter extends BoxPainter {
  _BorderPainter(
    this.decoration,
    this.indicatorHeight,
    this.textScaleFactor,
    VoidCallback onChanged,
  )   : assert(decoration != null),
        assert(indicatorHeight >= 0),
        super(onChanged);

  final BorderTabIndicator decoration;
  final double indicatorHeight;
  final double textScaleFactor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final horizontalInset = 16 - 4 * textScaleFactor;
    final rect = Offset(offset.dx + horizontalInset,
            (configuration.size.height / 2) - indicatorHeight / 2 - 1) &
        Size(configuration.size.width - 2 * horizontalInset, indicatorHeight);
    final paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(56)),
      paint,
    );
  }
}
