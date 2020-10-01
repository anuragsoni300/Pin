import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pin/backend/fetching/wallpaperfetching.dart';
import 'package:pin/backend/model/wallpapermodel.dart';
import 'package:pin/element/drawer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  final Color color;
  HomeScreen({this.color});
  @override
  _HomeScreenState createState() => _HomeScreenState(color: color);
}

class _HomeScreenState extends State<HomeScreen> {
  Wallpaper wall = Wallpaper();
  ScrollController _scrollController = new ScrollController();
  List<WallpaperModel> wallpa = [];
  bool _loading = true;
  int watch = 0;

  final Color color;
  _HomeScreenState({this.color});

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        watch++;
      }
      if (watch == 2) {
        watch = 0;
        getMoreData();
      }
    });
  }

  getMoreData() {
    print('object');
    setState(() {
      getData();
    });
  }

  getData() async {
    await wall.getWallPaper();
    wallpa = wall.wallpaper;
    setState(() {
      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffold = GlobalKey();
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawerr(
        scaffold: _scaffold,
      ),
      key: _scaffold,
      body: LiquidPullToRefresh(
        animSpeedFactor: 2.0,
        springAnimationDurationInMilliseconds: 400,
        onRefresh: () {
          return getData();
        },
        child: ListView.builder(
          itemCount: wallpa.length,
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                //Navigator.pop(context);
                Navigator.pushNamed(_scaffold.currentContext, '/detail',
                    arguments: {
                      'image': wallpa[index].urls,
                      'hash': wallpa[index].blurhash,
                      'index': index,
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Hero(
                      tag: 'wallpaper$index',
                      child: BlurHash(
                        hash: wallpa[index].blurhash,
                        image: wallpa[index].urls,
                        curve: Curves.bounceInOut,
                        imageFit: BoxFit.cover,
                        duration: Duration(milliseconds: 0),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
