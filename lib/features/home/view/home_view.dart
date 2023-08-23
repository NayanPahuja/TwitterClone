import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/constants/constants.dart';
class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appbar = UIConstants.appBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsConstants.homeOutlinedIcon),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsConstants.searchIcon),
              label: 'Search'),

        ],
      ),
    );
  }

}
