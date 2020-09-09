import 'package:igdb/model/game_models/genre.dart';
import 'package:igdb/model/game_models/keyword.dart';
import 'package:igdb/model/game_models/mode.dart';
import 'package:igdb/model/game_models/platform.dart';
import 'package:igdb/model/game_models/player_perspective.dart';
import 'package:igdb/model/game_models/screenshot.dart';
import 'package:igdb/model/game_models/video.dart';
import 'game_models/cover.dart';

class GameModel {
  final int id;
  final CoverModel cover;
  final int createdAt;
  final int firstRelease;
  final List<ModeModel> modes;
  final List<GenreModel> genres;
  final List<KeywordModel> keywords;
  final List<PlatformModel> platforms;
  final List<PlayerPerspectiveModel> perspectives;
  final double popularity;
  final List<ScreenshotModel> screenshots;
  final String summary;
  final List<VideoModel> videos;
  final double rating;
  final String name;

  GameModel(this.id, this.cover, this.createdAt, this.firstRelease, this.modes, this.genres, this.keywords, this.platforms, this.perspectives, this.popularity, this.screenshots, this.summary, this.videos, this.rating, this.name);

  GameModel.fromJson(Map<String, dynamic> json)
   : id = json["id"],
     cover = json["cover"] == null ? null : CoverModel.fromJson(json["cover"]),
     createdAt = json["created_at"],
     firstRelease = json["first_release_date"],
     modes = json["game_modes"] == null ? null : (json["game_modes"] as List).map((i) => new ModeModel.fromJson(i)).toList(),
     genres = json["genres"] == null ? null : (json["genres"] as List).map((i) => new GenreModel.fromJson(i)).toList(),
     keywords =  json["keywords"] == null ? null : (json["keywords"] as List).map((i) => new KeywordModel.fromJson(i)).toList(),
     platforms = json["platforms"] == null ? null : (json["platforms"] as List).map((i) => new PlatformModel.fromJson(i)).toList(),
     perspectives = json["player_perspectives"] == null ? null : (json["player_perspectives"] as List).map((i) => new PlayerPerspectiveModel.fromJson(i)).toList(),
     popularity = json["popularity"],
     screenshots = json["screenshots"] == null ? null : (json["screenshots"] as List).map((i) => new ScreenshotModel.fromJson(i)).toList(),
     summary = json["summary"],
     videos = json["videos"] == null ? null : (json["videos"] as List).map((i) => new VideoModel.fromJson(i)).toList(),
     rating = json["total_rating"],
     name = json["name"];
}