import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:igdb/model/game_response.dart';

class GameRepository {
  static String mainUrl = "https://api-v3.igdb.com";
  var gameListUrl = '$mainUrl/games';
  final String apiKey = "1d2f2ddd5bccde50d26b0fd178c09be7";
  final Dio _dio = Dio();

  Future<GameResponse> getGames() async {
    try {
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        options.headers["user-key"] = "$apiKey";
        _dio.interceptors.requestLock.unlock();
        return options;
      }));
      Response response =
          await _dio.post(gameListUrl, data: "fields artworks,bundles,category,checksum,collection,cover.*,created_at,first_release_date,follows,game_engines.*,game_modes.*,genres.*,hypes,keywords.*,multiplayer_modes,name,parent_game,platforms.*, platforms.platform_logo.*, player_perspectives.*,popularity,rating,rating_count,screenshots.*,slug,standalone_expansions,status,storyline,summary,tags,time_to_beat,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos.*; sort popularity desc;");
      return GameResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GameResponse.withError("$error");
    }
  }
  Future<GameResponse> getGames2(int platformId) async {
    var response = await http.post(gameListUrl,
        headers: {"Accept": "application/json", "user-key": "$apiKey"},
        body: "fields artworks,bundles,category,checksum,collection,cover.*,created_at,first_release_date,follows,game_engines.*,game_modes.*,release_dates, genres.*,hypes,keywords.*,multiplayer_modes,name,parent_game,platforms.*, platforms.platform_logo.*, player_perspectives.*,popularity,rating,rating_count,screenshots.*,slug,standalone_expansions,status,storyline,summary,tags,time_to_beat,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos.*;where cover.image_id != null & genres != null & videos != null & created_at > 1252214987 & platforms = $platformId & rating > 80; limit 100; sort popularity desc;");
    print("${response.statusCode}");
    return GameResponse.fromJson(jsonDecode(response.body));
  }
  Future<GameResponse> getSlider(int platformId) async {
    var response = await http.post(gameListUrl,
        headers: {"Accept": "application/json", "user-key": "$apiKey"},
        body: "fields artworks,bundles,category,checksum,collection,cover.*,created_at,first_release_date,follows,game_engines.*,game_modes.*,release_dates, genres.*,hypes,keywords.*,multiplayer_modes,name,parent_game,platforms.*, platforms.platform_logo.*, player_perspectives.*,popularity,rating,rating_count,screenshots.*,slug,standalone_expansions,status,storyline,summary,tags,time_to_beat,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos.*;where cover.image_id != null & screenshots != null & created_at > 1252214987 & platforms = $platformId; limit 100; sort created_at asc;");
    print("${response.statusCode}");
    return GameResponse.fromJson(jsonDecode(response.body));
  }
}