import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                children: <Widget>[
                  ClayContainer(
                    color: Theme.of(context).primaryColor,
                    borderRadius: 50,
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Image.asset(
                        'assets/pin-logo.png',
                        color:
                            Theme.of(context).primaryColor == Color(0xff2196f3)
                                ? Color(0xff2196f3)
                                : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
