import 'dart:convert';

import 'package:pin/backend/model/wallpapermodel.dart';
import 'package:http/http.dart' as http;

import 'package:pin/data/api_data.dart';

class Wallpaper {
  List<WallpaperModel> wallpaper = [];

  Future<List<WallpaperModel>> getWallPaper(page) async {
    String link =
      'https://api.unsplash.com/photos/?client_id=$kAccessKey&per_page=5&page=$page';
    var response = await http.get(link);
    var jsondata = jsonDecode(response.body);

    jsondata.forEach(
      (element) {
        WallpaperModel articalModel = WallpaperModel(
          id: element['id'],
          likes: element['likes'],
          urls: element['urls']['small'],
          blurhash: element['blur_hash'],
        );
        wallpaper.add(articalModel);
      },
    );
    return wallpaper;
  }
}
