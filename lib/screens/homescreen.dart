import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pin/element/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:pin/data/api_data.dart';

class HomeScreen extends StatefulWidget {
  final Color color;
  HomeScreen({this.color});
  @override
  _HomeScreenState createState() => _HomeScreenState(color: color);
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 1;
  dynamic _wallpapers = [];
  dynamic _parsedResponse = '';
  final Color color;
  _HomeScreenState({this.color});
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
      body: _wallpapers.isEmpty
          ? FutureBuilder(
              future: wallfetch(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  _wallpapers = snapshot.data.toList().map(
                        (photo) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                _scaffold.currentContext, '/details',
                                arguments: {
                                  'id': photo['id'],
                                  'urls_raw': photo['urls']['raw'],
                                  'urls_regular': photo['urls']['regular'],
                                  'user': photo['user'],
                                  'likes': photo['likes'],
                                  'color': photo['color'],
                                  'width': photo['width'],
                                  'height': photo['height'],
                                  'created_at': photo['created_at'],
                                  'links_html': photo['links']['html'],
                                });
                          },
                          child: Container(
                            child: Hero(
                              tag: photo['id'],
                              child: Image.network(photo['urls']['small']),
                            ),
                          ),
                        ),
                      );
                  return _renderWallpapers();
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          : _renderWallpapers(),
    );
  }

  Widget _renderWallpapers() => ListView(
        children: <Widget>[
          ..._wallpapers,
        ],
      );

  Future wallfetch() async {
    http.Response response = await http.get(
        'https://api.unsplash.com/photos/?client_id=$kAccessKey&per_page=30&page=$_page');
    _parsedResponse = json.decode(response.body);
    return _parsedResponse;
  }
}
