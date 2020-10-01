import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pin/element/drawerelements.dart';

class Detail extends StatefulWidget {
  final ImageProvider image;

  const Detail({Key key, this.image});
  @override
  _DetailState createState() => _DetailState(image);
}

class _DetailState extends State<Detail> {
  final ImageProvider image;

  _DetailState(this.image);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> detail = ModalRoute.of(context).settings.arguments;
    int index = detail['index'];
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(45, 45, 45, 1)
          : Color(0xFFF2F2F2),
      body: SingleChildScrollView(clipBehavior: Clip.none,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                child: ClayContainer(
                  borderRadius: 20,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(45, 45, 45, 1)
                      : Color(0xFFF2F2F2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Hero(
                      tag: 'wallpaper$index',
                      child: BlurHash(
                        hash: detail['hash'],
                        image: detail['image'],
                        curve: Curves.bounceInOut,
                        imageFit: BoxFit.cover,
                        duration: Duration(milliseconds: 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.16,
                width: MediaQuery.of(context).size.width,
                child: ClayContainer(
                  borderRadius: 20,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(45, 45, 45, 1)
                      : Color(0xFFF2F2F2),
                  // child: Row(
                  //   children: <Widget>[
                  //     Icon(Icons.photo_size_select_actual),
                  //     Text(
                  //       '    Size  ',
                  //     ),
                  //     Text(
                  //       detail['height'].toString(),
                  //     ),
                  //     Text(
                  //       ' x ',
                  //     ),
                  //     Text(
                  //       detail['width'].toString(),
                  //     ),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Icon(Icons.favorite),
                  //     Text(
                  //       '   ',
                  //     ),
                  //     Text(
                  //       detail['likes'].toString(),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
