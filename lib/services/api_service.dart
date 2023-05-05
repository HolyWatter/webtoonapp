import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoonapp/models/webtoon_detail_model.dart';
import 'package:webtoonapp/models/webtoon_edpisode_model.dart';
import 'package:webtoonapp/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const  String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons()async {
    List<WebtoonModel> webtoonInstance = [];
    final url = Uri.parse('$baseUrl/$today');
    final res = await http.get(url);
    if(res.statusCode == 200){
     final List<dynamic> webtoons = jsonDecode(res.body);
    for (var webtoon in webtoons){
      webtoonInstance.add(WebtoonModel.fromJson(webtoon));
    }
  return webtoonInstance;
    }
    throw Error();
  }
static Future<List<WebtoonEpisodeModel>> getWebtoonEpisode(id) async{
    List<WebtoonEpisodeModel> episodesInstance = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final res = await http.get(url);

    if(res.statusCode == 200){
      final List<dynamic> episodes = jsonDecode(res.body);
    for(var episode in episodes){
        episodesInstance.add(WebtoonEpisodeModel.fromJson(episode));
    }
    return episodesInstance;
    }
    throw Error();
  }


  static Future<WebtoonDetailModel> getWebtoonDetail(id) async{
    final url = Uri.parse('$baseUrl/$id');
    final res = await http.get(url);
    if(res.statusCode == 200){
      final webtoon = jsonDecode(res.body);

      return WebtoonDetailModel.fromJson(webtoon);
    }
   throw Error();
  }

  
}