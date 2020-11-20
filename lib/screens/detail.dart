import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intent/intent.dart' as intent;
import 'package:intent/action.dart' as action;
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pin/backend/database/database_helper.dart';
import 'package:pin/data/data.dart';

class Detail extends StatefulWidget {
  final ImageProvider image;

  const Detail({Key key, this.image});
  @override
  _DetailState createState() => _DetailState(image);
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    super.initState();
    checkfav();
  }

  checkfav() async {
    bool data = await DatabaseHelper.instance.queryFav(favdata);
    setState(() {
      notfav = data;
    });
  }

  bool notfav = false;
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
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: ClayContainer(
                  borderRadius: 20,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromRGBO(45, 45, 45, 1)
                      : Color.fromRGBO(242, 242, 242, 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: 'wallpaper$index',
                          child: BlurHash(
                            hash: detail['hash'],
                            image: detail['image'],
                            curve: Curves.bounceInOut,
                            imageFit: BoxFit.cover,
                            duration: Duration(milliseconds: 0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                              _save(detail['image']);
                              intent.Intent()
                                ..setAction(action.Action.ACTION_SET_WALLPAPER)
                                ..startActivityForResult().then(
                                  (_) => print(_),
                                  onError: (e) => print(e),
                                );
                            },
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromRGBO(242, 242, 242, 0.35)
                                          : Color.fromRGBO(45, 45, 45, 0.35)),
                                  child: Center(
                                      child: Text(
                                    'SET AS WALLPAPER',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Color.fromRGBO(45, 45, 45, 1)
                                          : Color.fromRGBO(242, 242, 242, 1),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                          IconButton(
                            icon: Icon(notfav
                                ? Icons.favorite_border
                                : Icons.favorite),
                            onPressed: () {
                              if (!notfav) {
                                DatabaseHelper.instance.delete(detail['id']);
                              } else {
                                DatabaseHelper.instance.insert(
                                  {
                                    DatabaseHelper.id: detail['id'],
                                    DatabaseHelper.urls: detail['image'],
                                    DatabaseHelper.blurhash: detail['hash'],
                                    DatabaseHelper.width: detail['width'],
                                    DatabaseHelper.height: detail['height'],
                                    DatabaseHelper.likes: detail['likes'],
                                    DatabaseHelper.description:
                                        detail['description'],
                                    DatabaseHelper.links: detail['links'],
                                    DatabaseHelper.portfolioimage:
                                        detail['portfolioimage'],
                                  },
                                );
                              }
                              setState(() {
                                notfav = !notfav;
                              });
                            },
                          ),
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
                          IconButton(
                            icon: Icon(Icons.file_download),
                            onPressed: () async {
                              _save(detail['image']);
                              // if (await canLaunch(detail['image']))
                              //   launch(detail['image']);
                            },
                          ),
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

  _save(url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }
}
