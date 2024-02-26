

import 'dart:convert';

import 'package:flutter_side_project/models/webtoon_episode.model.dart';
import 'package:flutter_side_project/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

import '../models/webtoon_detail_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev/";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons()async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl$today');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }

      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final uri = Uri.parse('$baseUrl$id');
    final response = await http.get(uri);

    if(response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }

    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisode(String id) async {
    List<WebtoonEpisodeModel> webtoonEpisodeInstances = [];

    final uri = Uri.parse('$baseUrl$id/episodes');
    final response = await http.get(uri);

    if(response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for(var episode in episodes){
        webtoonEpisodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return webtoonEpisodeInstances;
    }

    throw Error();
  }

}