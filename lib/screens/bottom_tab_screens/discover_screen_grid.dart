import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:igdb/bloc/get_games_bloc.dart';
import 'package:igdb/elements/error_element.dart';
import 'package:igdb/elements/loader_element.dart';
import 'package:igdb/model/game.dart';
import 'package:igdb/model/game_response.dart';
import 'package:igdb/style/theme.dart' as Style;

import '../game_detail_screen.dart';

class DiscoverScreenGrid extends StatefulWidget {
  @override
  _DiscoverScreenGridState createState() => _DiscoverScreenGridState();
}

class _DiscoverScreenGridState extends State<DiscoverScreenGrid> {
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
    return _buildGameGridWidget(snapshot.data);
            } else if (snapshot.hasError) {
    return buildErrorWidget(snapshot.error);
            } else {
    return buildLoadingWidget();
            }
          },
        );
  }
  Widget _buildGameGridWidget(GameResponse data) {
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
      child: AnimationLimiter(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: GridView.count(
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
          crossAxisCount: 3,
          children: List.generate(
            games.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameDetailScreen(
                                game: games[index],)));
                      },
                                          child: Stack(
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
                          AspectRatio(
                              aspectRatio: 3/4,
                                child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.0)],
                                    stops: [
                                      0.0,
                                      0.5
                                    ]
                                  )
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 20.0,
                            left: 5.0,
                            child: Container(
                              width: 90.0,
                              child: Text(games[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                          Positioned(
                            bottom: 5.0,
                            left: 5.0,
                            child: Row(
                                children: [
                                  RatingBar(
                        itemSize: 6.0,
   initialRating: games[index].rating / 20,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold
                                  ),)
                                ],
                              ),
                          )
                        ],                   
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
    );
  }
}