import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:igdb/bloc/get_games_bloc.dart';
import 'package:igdb/elements/error_element.dart';
import 'package:igdb/elements/loader_element.dart';
import 'package:igdb/model/game.dart';
import 'package:igdb/model/game_response.dart';
import 'package:igdb/screens/game_detail_screen.dart';
import 'package:igdb/style/theme.dart' as Style;

class DiscoverScreenList extends StatefulWidget {
  @override
  _DiscoverScreenListState createState() => _DiscoverScreenListState();
}

class _DiscoverScreenListState extends State<DiscoverScreenList> {

  @override
  void initState() {
    super.initState();
    getGamesBloc..getGames(48);

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameResponse>(
          stream: getGamesBloc.subject.stream,
          builder: (context, AsyncSnapshot<GameResponse> snapshot) {
            if (snapshot.hasData) {
    if (snapshot.data.error != null && snapshot.data.error.length > 0) {
      return buildErrorWidget(snapshot.data.error);
    }
    return _buildGameListWidget(snapshot.data);
            } else if (snapshot.hasError) {
    return buildErrorWidget(snapshot.error);
            } else {
    return buildLoadingWidget();
            }
          },
        );
  }
  Widget _buildGameListWidget(GameResponse data) {
    List<GameModel> games = data.games;
    if (games.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No game to show",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return AnimationLimiter(
      child: ListView.builder(
        itemCount: games.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameDetailScreen(
                                game: games[index],)));
                  },
                                  child: Container(
                    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                    height: 150.0,
                    child: Row(
                      children: [
                        Hero(
                          tag: games[index].id,
                                                  child: AspectRatio(
                            aspectRatio: 3/4,
                              child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://images.igdb.com/igdb/image/upload/t_cover_big/${games[index].cover.imageId}.jpg", 
                                  ),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(games[index].name, 
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14.0
                                ),),
                                SizedBox(
                                  height: 5.0,
                                ),
                                
                                  Text(games[index].summary, maxLines: 4, style: TextStyle(
                                    color: Colors.white.withOpacity(0.2),
                                    fontSize: 12.0
                                  ),)
                                ],
                              ),
                              Row(
                                children: [
                                  RatingBar(
                        itemSize: 8.0,
   initialRating: games[index].rating / 20,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
   itemBuilder: (context, _) => Icon(
     EvaIcons.star,
     color: Style.Colors.secondaryColor,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Text((games[index].rating/20).toString().substring(0,3), style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0
                                  ),)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}