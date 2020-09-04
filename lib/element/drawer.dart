import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:pin/element/drawerelements.dart';

class Drawerr extends StatefulWidget {
  final GlobalKey scaffold;
  Drawerr({this.scaffold});
  @override
  _DrawerrState createState() => _DrawerrState(scaffold: scaffold);
}

class _DrawerrState extends State<Drawerr> {
  final GlobalKey scaffold;
  _DrawerrState({this.scaffold});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Column(
                  children: <Widget>[
                    ClayContainer(
                      depth: 50,
                      curveType: CurveType.concave,
                      color: Theme.of(context).primaryColor,
                      borderRadius: 50,
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/pin-logo.png',
                        color:
                            Theme.of(context).primaryColor == Color(0xff2196f3)
                                ? Color(0xff2196f3)
                                : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: icons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        String texts = text[index];
                        Navigator.pushNamed(scaffold.currentContext, '/$texts');
                      },
                      child: ClayContainer(
                        curveType: CurveType.concave,
                        borderRadius: 10,
                        height: 60,
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                          trailing: Text(
                            text[index],
                            style: TextStyle(
                              fontSize: 28,
                              color: Theme.of(context).primaryColor ==
                                      Color(0xff2196f3)
                                  ? Color(0xff2196f3)
                                  : Colors.white,
                            ),
                          ),
                          leading: Icon(icons[index].icon),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
