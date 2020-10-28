import 'package:clay_containers/clay_containers.dart';
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
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color.fromRGBO(45, 45, 45, 1)
          : Color.fromRGBO(242, 242, 242, 1),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(45, 45, 45, 1)
                  : Color.fromRGBO(242, 242, 242, 1),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                child: ClayContainer(
                  borderRadius: 20,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(45, 45, 45, 1)
                      : Color.fromRGBO(242, 242, 242, 1),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClayContainer(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(45, 45, 45, 1)
                        : Color.fromRGBO(242, 242, 242, 1),
                    borderRadius: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.image),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            detail['height'].toString() +
                                ' x ' +
                                detail['width'].toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClayContainer(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(45, 45, 45, 1)
                        : Color.fromRGBO(242, 242, 242, 1),
                    borderRadius: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            detail['likes'].toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClayContainer(
                    borderRadius: 10,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(45, 45, 45, 1)
                        : Color.fromRGBO(242, 242, 242, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              detail['portfolioimage'],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            detail['description'].toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClayContainer(
                    borderRadius: 10,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(45, 45, 45, 1)
                        : Color.fromRGBO(242, 242, 242, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.file_download),
                          Text(
                            '  download',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
