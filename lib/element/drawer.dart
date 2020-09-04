import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class Drawerr extends StatefulWidget {
  final Color color;
  Drawerr(this.color);
  @override
  _DrawerrState createState() => _DrawerrState(color);
}

class _DrawerrState extends State<Drawerr> {
  final Color color;
  _DrawerrState(this.color);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: color,
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: color,
          ),
          child: Column(
            children: <Widget>[
              ClayContainer(
                color: color,
                borderRadius: 50,
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: color,
                  child: Image.asset('assets/pin-logo.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
