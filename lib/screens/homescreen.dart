import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pin/backend/fetching/wallpaperfetching.dart';
import 'package:pin/backend/model/wallpapermodel.dart';
import 'package:pin/data/data.dart';
import 'package:pin/element/drawer.dart';
import 'package:sqflite/sqlite_api.dart';

class HomeScreen extends StatefulWidget {
  final Color color;
  HomeScreen({this.color});
  @override
  _HomeScreenState createState() => _HomeScreenState(color: color);
}

class _HomeScreenState extends State<HomeScreen> {
  Database database;
  bool _loading = true;
  final Wallpaper wall = Wallpaper();
  List<WallpaperModel> wallpa = [];
  final Color color;
  _HomeScreenState({this.color});

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await wall.getWallPaper();
    wallpa = wall.wallpapers;
    setState(() {
      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffold = GlobalKey();
    return Scaffold(
      drawer: Drawerr(
        scaffold: _scaffold,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'PIN',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            centerTitle: true,
            iconTheme: new IconThemeData(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            floating: true,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color.fromRGBO(48, 48, 48, 1)
                : Colors.white,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == wallpa.length - 1) {
                  getData();
                }
                return GestureDetector(
                  onTap: () async {
                    favdata = wallpa[index].id;
                    Navigator.pushNamed(context, '/detail', arguments: {
                      'id': wallpa[index].id,
                      'image': wallpa[index].urls,
                      'hash': wallpa[index].blurhash,
                      'index': index,
                      'width': wallpa[index].width,
                      'height': wallpa[index].height,
                      'likes': wallpa[index].likes,
                      'description': wallpa[index].description,
                      'links': wallpa[index].links,
                      'portfolioimage': wallpa[index].portfolioimage,
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
              childCount: wallpa.length,
            ),
          ),
        ],
      ),
    );
  }
}
