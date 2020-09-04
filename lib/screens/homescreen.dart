import 'package:flutter/material.dart';
import 'package:pin/element/drawer.dart';

class HomeScreen extends StatefulWidget {
  final Color color;
  HomeScreen({this.color});
  @override
  _HomeScreenState createState() => _HomeScreenState(color: color);
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Stack(
        children: <Widget>[],
      ),
    );
  }
}
