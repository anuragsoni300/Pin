import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pin/backend/fetching/wallpaperfetching.dart';
import 'package:pin/backend/model/wallpapermodel.dart';
import 'package:pin/element/drawer.dart';

class HomeScreen extends StatefulWidget {
  final Color color;
  HomeScreen({this.color});
  @override
  _HomeScreenState createState() => _HomeScreenState(color: color);
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = new ScrollController();
  List<WallpaperModel> wallpa = [];
  bool _loading = true;
  int _page = 1;

  final Color color;
  _HomeScreenState({this.color});

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getMoreData();
      }
    });
  }

  getMoreData(){
    print('object');
    setState(() {
      _page++;
    });
    getData();
  }

  getData() async {
    Wallpaper wall = new Wallpaper();
    await wall.getWallPaper(_page);
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
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: wallpa.length,
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 300,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: BlurHash(
                        hash: wallpa[index].blurhash,
                        image: wallpa[index].urls,
                        curve: Curves.bounceInOut,
                        imageFit: BoxFit.cover,
                        duration: Duration(milliseconds: 500),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
