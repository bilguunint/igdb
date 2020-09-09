import 'package:flutter/material.dart';
import 'package:igdb/bloc/get_games_bloc.dart';
import 'package:igdb/bloc/get_slider_bloc.dart';
import 'package:igdb/elements/error_element.dart';
import 'package:igdb/elements/loader_element.dart';
import 'package:igdb/model/game.dart';
import 'package:igdb/model/game_response.dart';
import 'package:igdb/style/theme.dart' as Style;
import 'package:page_indicator/page_indicator.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    getSliderBloc..getSlider(48);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameResponse>(
      stream: getSliderBloc.subject.stream,
      builder: (context, AsyncSnapshot<GameResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeSliderWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHomeSliderWidget(GameResponse data) {
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
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 180.0,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: games.take(5).length,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.mainColor,
          indicatorSelectorColor: Style.Colors.secondaryColor,
          shape: IndicatorShape.circle(size: 5.0),
          pageView: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: games.take(5).length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: games[index].id,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 180.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://images.igdb.com/igdb/image/upload/t_screenshot_huge/${games[index].screenshots[0].imageId}.jpg")),
                          )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [
                              0.0,
                              0.9
                            ],
                            colors: [
                              Color(0xff20232a).withOpacity(1.0),
                              Style.Colors.backgroundColor.withOpacity(0.0)
                            ]),
                      ),
                    ),
                    Positioned(
                        left: 10.0,
                        bottom: 0.0,
                        child: Container(
                          height: 90.0,
                          child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "https://images.igdb.com/igdb/image/upload/t_cover_big/${games[index].cover.imageId}.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                      ),
                    ),
                        )),
                    Positioned(
                        bottom: 30.0,
                        left: 80.0,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 250.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                games[index].name,
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )),
                        
                  ],
                ),
              );
            },
          ),
        ),
      );
  }
}
