import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pin/backend/database/database_helper.dart';
import 'package:pin/data/data.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    super.initState();
    getfav();
  }

  void getfav() async {
    fav = await DatabaseHelper.instance.queryAll();
    setState(() {
      get();
    });
  }

  get() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'FAVORITE',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            centerTitle: true,
            iconTheme: new IconThemeData(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            floating: true,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color.fromRGBO(48, 48, 48, 1)
                : Colors.white,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => GestureDetector(
                onTap: () async {
                  favdata = fav[index]['id'];
                  Navigator.pushNamed(context, '/detail', arguments: {
                    'id': fav[index]['id'],
                    'image': fav[index]['urls'],
                    'hash': fav[index]['blurhash'],
                    'index': index,
                    'width': fav[index]['width'],
                    'height': fav[index]['height'],
                    'likes': fav[index]['likes'],
                    'description': fav[index]['description'],
                    'links': fav[index]['links'],
                    'portfolioimage': fav[index]['portfolioimage'],
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 300,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Hero(
                        tag: index,
                        child: BlurHash(
                          hash: fav[index]['blurhash'],
                          image: fav[index]['urls'],
                          curve: Curves.bounceInOut,
                          imageFit: BoxFit.cover,
                          duration: Duration(milliseconds: 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              childCount: fav.length,
            ),
          ),
        ],
      ),
    );
  }
}
