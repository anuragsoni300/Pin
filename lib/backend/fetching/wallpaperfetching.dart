import 'dart:convert';

import 'package:pin/backend/model/wallpapermodel.dart';
import 'package:http/http.dart' as http;

import 'package:pin/data/api_data.dart';

class Wallpaper {
  int page = 0;
  List<WallpaperModel> wallpaper = [];

  Future<List<WallpaperModel>> getWallPaper() async {
    page++;
    String link =
<<<<<<< HEAD
        'https://api.unsplash.com/photos/?client_id=$kAccessKey&per_page=10&page=$page';
=======
        'https://api.unsplash.com/photos/?client_id=$kAccessKey&per_page=4&page=$page';
>>>>>>> ceb6de670de9eee4c4ed8acb6b3c8592c6681adc
    var response = await http.get(link);
    var jsondata = jsonDecode(response.body);

    jsondata.forEach(
      (element) {
        if (element['blur_hash'] != null) {
          WallpaperModel articalModel = WallpaperModel(
            id: element['id'],
            likes: element['likes'],
            urls: element['urls']['small'],
            blurhash: element['blur_hash'],
            description: element['user']['name'],
            height: element['height'],
            links: element['links']['portfolio'],
            width: element['width'],
            portfolioimage: element['user']['profile_image']['large'],
          );
          wallpaper.add(articalModel);
        }
      },
    );
    return wallpaper;
  }
}
