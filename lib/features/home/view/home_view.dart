import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/views/create_tweet_view.dart';
import 'package:twitter_clone/theme/pallete.dart';
class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appbar = UIConstants.appBar();


  void onPageChange(int index){
    setState(() {
      _page = index;
    });
  }

  onCreateTweet(){
    Navigator.pushNamed(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        backgroundColor: Pallete.blueColor,
        child: const Icon(
          Icons.add,
        color: Pallete.whiteColor,
        size: 24,),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                color: Pallete.whiteColor, _page == 0? AssetsConstants.homeFilledIcon : AssetsConstants.homeOutlinedIcon),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsConstants.searchIcon,color: Pallete.whiteColor,),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(color: Pallete.whiteColor, _page == 2? AssetsConstants.notifFilledIcon : AssetsConstants.notifOutlinedIcon),
              label: 'Notifications'),

        ],
      ),
    );
  }

}
