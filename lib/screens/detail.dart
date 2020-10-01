import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

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
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 10,
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
          )
        ],
      ),
    );
  }
}
