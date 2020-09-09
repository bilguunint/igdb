import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:igdb/bloc/switch_bloc.dart';
import 'package:igdb/model/game.dart';
import 'package:igdb/model/game_response.dart';
import 'package:igdb/style/theme.dart' as Style;
import 'package:igdb/widgets/home_slider.dart';

import 'bottom_tab_screens/discover_screen_grid.dart';
import 'bottom_tab_screens/discover_screen_list.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  SwitchBloc _switchBloc;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _switchBloc = SwitchBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showSingle() {
    print("Single Clicked");
    _switchBloc.showSingle();
  }

  void _showList() {
    print("List Clicked");
    _switchBloc.showList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF20232a),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0.5,
          iconTheme: IconThemeData(
            color: Style.Colors.mainColor,
          ),
          centerTitle: true,
          backgroundColor: Style.Colors.backgroundColor,
          title: Text(
            "IGDB",
            style: TextStyle(color: Colors.white, fontSize: 17.0),
          ),
          actions: [],
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeSlider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Popular games right now".toUpperCase(),
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    StreamBuilder<SwitchItem>(
                      stream: _switchBloc.itemStream,
                      initialData: _switchBloc.defaultItem,
                      // ignore: missing_return
                      builder: (BuildContext context,
                          AsyncSnapshot<SwitchItem> snapshot) {
                        switch (snapshot.data) {
                          case SwitchItem.LIST:
                            return IconButton(
                                icon: Icon(
                                  SimpleLineIcons.list,
                                  size: 18.0,
                                ),
                                color: Colors.white,
                                onPressed: _showSingle);
                          case SwitchItem.GRID:
                            return IconButton(
                                icon: Icon(SimpleLineIcons.grid, size: 18.0),
                                color: Colors.white,
                                onPressed: _showList);
                        }
                      },
                    )
                  ],
                ),
                Expanded(
                  child: StreamBuilder<SwitchItem>(
                    stream: _switchBloc.itemStream,
                    initialData: _switchBloc.defaultItem,
                    // ignore: missing_return
                    builder: (BuildContext context, AsyncSnapshot<SwitchItem> snapshot) {
                      switch (snapshot.data) {
                        case SwitchItem.LIST:
                          return DiscoverScreenGrid();
                        case SwitchItem.GRID:
                          return DiscoverScreenList();
                      }
                    },
                  ),
                ),
              ],
            ),
            Container(
              color: Style.Colors.backgroundColor,
            ),
            Container(
              color: Style.Colors.backgroundColor,
            ),
            Container(
              color: Style.Colors.backgroundColor,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: BottomNavyBar(
          containerHeight: 56.0,
          backgroundColor: Style.Colors.backgroundColor,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                ' Discover',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.game_controller,
                  size: 18.0,
                  color: _currentIndex == 0
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                ' Search',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.magnifier,
                  size: 18.0,
                  color: _currentIndex == 1
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                ' Console',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.layers,
                  size: 18.0,
                  color: _currentIndex == 2
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
            BottomNavyBarItem(
              activeColor: Color(0xFF010101),
              title: Text(
                ' Profile',
                style: TextStyle(color: Style.Colors.mainColor, fontSize: 13.0),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  SimpleLineIcons.user,
                  size: 18.0,
                  color: _currentIndex == 3
                      ? Style.Colors.mainColor
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
