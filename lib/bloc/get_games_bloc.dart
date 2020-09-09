import 'package:igdb/model/game_response.dart';
import 'package:igdb/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GetGamesBloc {
  final GameRepository _repository = GameRepository();
  final BehaviorSubject<GameResponse> _subject = 
          BehaviorSubject<GameResponse>();
  
  getGames(int platformId) async {
    GameResponse response = await _repository.getGames2(platformId);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GameResponse> get subject => _subject;

}
final getGamesBloc = GetGamesBloc();