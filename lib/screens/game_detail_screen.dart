import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:igdb/model/game.dart';
import 'package:igdb/model/game_models/screenshot.dart';
import 'package:igdb/model/item.dart';
import 'package:igdb/style/theme.dart' as Style;
import 'package:page_indicator/page_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GameDetailScreen extends StatefulWidget {
  final GameModel game;
  GameDetailScreen({Key key, @required this.game}) : super(key: key);
  @override
  _GameDetailScreenState createState() => _GameDetailScreenState(game);
}

class _GameDetailScreenState extends State<GameDetailScreen> with SingleTickerProviderStateMixin{
  YoutubePlayerController _controller;
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
      TabController _tabController;
  final GameModel game;
  final tabs = <Item>[
    Item(id: 0, name: "OVERVIEW"),
    Item(id: 1, name: "SCREESHOTS")
  ];
  final customColors = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: Style.Colors.grey,
    progressBarColor: Style.Colors.mainColor,
    hideShadow: true
 );
  _GameDetailScreenState(this.game);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _controller = YoutubePlayerController(
    initialVideoId: game.videos[0].videoId,
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
    ),
);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF20232a),
      body: Column(
        children: [
          Stack(
                  children: <Widget>[
                    
                    Container(
        height: 220.0,
        child: YoutubePlayer(
    controller: _controller,
    showVideoProgressIndicator: true,
),
      ),
      Positioned(
        top: 20.0,
        left: 0.0,
              child: IconButton(icon: Icon(EvaIcons.arrowBack, color: Colors.white,), onPressed: () {
          Navigator.pop(context);
        }),
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
                      bottom: 10.0,
                      left: 10.0,
                                          child: Container(
                        height: 55,
                        width: 55,
                                            child: SleekCircularSlider(
  appearance: CircularSliderAppearance(
      angleRange: 360,
      customColors: customColors,
      customWidths: CustomSliderWidths(progressBarWidth: 4, trackWidth: 2)),
  min: 0,
  max: 100,
  initialValue: game.rating,
  innerWidget: (double value) {
      return Column(
        children: <Widget>[
        Expanded(
                  child: Align(
                        alignment: Alignment.center,
                                          child: Hero(
                                            tag: game.id,
                                                                                      child: ClipOval(
                            child: 
                            Image.network(
                          "https://images.igdb.com/igdb/image/upload/t_cover_big/${game.cover.imageId}.jpg",
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        )),
                                          ),
                  ),
        ),
        ],
      );
  },
),
                      ),
                    ),
                    
                    Positioned(
                        bottom: 26.0,
                        left: 75.0,
                        child: Text(
                          game.name,
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )),
                        
                  ],
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Style.Colors.mainColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 2.0,
                  unselectedLabelColor: Colors.white,
                  labelColor: Style.Colors.mainColor,
                  isScrollable: false,
                  tabs: tabs.map((Item genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                        child: new Text(genre.name,
                            style: TextStyle(
                                fontSize: 13.0, fontFamily: "SFPro-Medium")));
                  }).toList(),
                ),
                Expanded(
                  
                                  child: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ListView(
            
            children: [
              Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Summary".toUpperCase(),
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(game.summary,
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.white.withOpacity(0.5)
                    ),),
                  ),
                  Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                        child: Text(
                          "perspectives".toUpperCase(),
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    Container(
                  height: 30.0,
                  padding: EdgeInsets.only(left: 10.0, top: 5.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: game.perspectives.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
                          child: Text(
                            game.perspectives[index].name,
                            maxLines: 2,
                            style: TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0),
                          ),
                        ),
                      );
                    },
                  ),
              ),
              Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 15.0),
                        child: Text(
                          "Genres".toUpperCase(),
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    Container(
                  height: 30.0,
                  padding: EdgeInsets.only(left: 10.0, top: 5.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: game.genres.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
                          child: Text(
                            game.genres[index].name,
                            maxLines: 2,
                            style: TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0),
                          ),
                        ),
                      );
                    },
                  ),
              )
            ],
          ),
          Column(
            children: [
              Expanded(
                                child: AnimationLimiter(
      child: AnimationLimiter(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: GridView.count(
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.33,
          crossAxisCount: 3,
          children: List.generate(
            game.screenshots.length,
            (int index) {
                  return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: 3,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: AspectRatio(
                          aspectRatio: 4/3,
                            child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.igdb.com/igdb/image/upload/t_screenshot_big/${game.screenshots[index].imageId}.jpg", 
                                ),
                                fit: BoxFit.cover
                              )
                            ),
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
    ),
              )
            ],
          )
        ]),
                ),
                
              
                
        ],
      ),
    );
  }
  getExpenseSliders(List<ScreenshotModel> screenshots) {
    return screenshots.map((screenshot) => 
    Container(
      padding: EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        top: 10.0,
        bottom: 10.0
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage("https://images.igdb.com/igdb/image/upload/t_screenshot_huge/${screenshot.imageId}.jpg")
          )
        ),
      ),
    )
    ).toList();
  }
}