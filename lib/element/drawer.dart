import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:pin/element/drawerelements.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width / 2.1,
      child: Drawer(
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
                          color: Theme.of(context).primaryColor ==
                                  Color(0xff2196f3)
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
                          Navigator.pushNamed(context, '/$texts');
                        },
                        child: ClayContainer(
                          curveType: CurveType.concave,
                          borderRadius: 10,
                          height: 50,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      if (await canLaunch('https://github.com/anuragsoni300'))
                        launch('https://github.com/anuragsoni300');
                    },
                    child: ClayContainer(
                      curveType: CurveType.concave,
                      borderRadius: 10,
                      height: 100,
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 10,
                              backgroundImage: NetworkImage(
                                  'https://avatars2.githubusercontent.com/u/42229055?s=400&u=f93b187ca2023a263efefc592c0a59918e7b1330&v=4'),
                            ),
                            Text(
                              'Github',
                              style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).primaryColor ==
                                        Color(0xff2196f3)
                                    ? Color(0xff2196f3)
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
