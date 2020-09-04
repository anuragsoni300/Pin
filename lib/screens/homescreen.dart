import 'package:flutter/material.dart';
import 'package:pin/element/drawer.dart';

class HomeScreen extends StatefulWidget {
  final Color primarySwatch;
  HomeScreen(this.primarySwatch);
  @override
  _HomeScreenState createState() => _HomeScreenState(primarySwatch);
}

class _HomeScreenState extends State<HomeScreen> {
  final Color primarySwatch;
  _HomeScreenState(this.primarySwatch);
  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffold = GlobalKey();
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Scaffold.of(context).openDrawer();
            Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(milliseconds: 400), content: Text('data')));
          },
        ),
      ),
      drawer: Drawerr(primarySwatch),
      key: _scaffold,
      body: Stack(
        children: <Widget>[
          RaisedButton(onPressed: () {
            Navigator.pushNamed(_scaffold.currentContext, '/setting');
          })
        ],
      ),
    );
  }
}
