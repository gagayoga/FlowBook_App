import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:reyhan_flowbook/app/modules/bookmark/views/bookmark_view.dart';
import 'package:reyhan_flowbook/app/modules/explorer/views/explorer_view.dart';
import 'package:reyhan_flowbook/app/modules/historypeminjaman/views/historypeminjaman_view.dart';
import 'package:reyhan_flowbook/app/modules/home/views/home_view.dart';
import 'package:reyhan_flowbook/app/modules/profile/views/profile_view.dart';

class CustomBottomBar extends StatelessWidget {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);


  List<Widget> screenDshboard() {
    return [
      const SafeArea(child: HomeView()),
      const SafeArea(child: ExplorerView()),
      const SafeArea(child: BookmarkView()),
      const SafeArea(child: HistorypeminjamanView()),
      const SafeArea(child: ProfileView()),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: const Color(0xFF008A93),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.book),
        title: ("Explore"),
        activeColorPrimary: const Color(0xFF008A93),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bookmark),
        title: ("Bookmark"),
        activeColorPrimary: const Color(0xFF008A93),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history_rounded),
        title: ("History"),
        activeColorPrimary: const Color(0xFF008A93),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: ("Settings"),
        activeColorPrimary: const Color(0xFF008A93),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  CustomBottomBar({
    super.key,
    controller,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final appbar = MediaQuery.of(context).padding.top;
    final heightBody = height - appbar;

    return SafeArea(
      child: Container(
        height: heightBody,
        child: PersistentTabView(
          context,
          controller: controller,
          screens: screenDshboard(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          navBarHeight: 65.0,
          backgroundColor: Colors.black,
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 500),
            curve: ElasticInOutCurve(20),
          ),
          screenTransitionAnimation: const  ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: ElasticInOutCurve(20),
            duration: Duration(milliseconds: 500),
          ),
          navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
