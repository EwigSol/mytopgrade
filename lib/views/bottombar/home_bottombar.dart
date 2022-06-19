import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:topgrade/utils/color_manager.dart';
import 'package:topgrade/views/screens/courses/MyCourses.dart';
import 'package:topgrade/views/screens/favourites/favourites_screen.dart';
import 'package:topgrade/views/screens/home/home_screen.dart';
import 'package:topgrade/views/screens/profile/profile_screen.dart';
import 'package:topgrade/views/screens/quiz/quiz_assignment_screen.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  late PersistentTabController _controller;

  @override
  initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> navScreens() {
    return [
      const HomeScreen(),
      const MyCourses(),
      // const QuizAssignmentScreen(),
      const FavouritesScreen(),
      // const ChatListScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: ColorManager.blackColor,
          activeColorSecondary: ColorManager.primaryColor,
          inactiveColorSecondary: ColorManager.blackColor),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.description),
          title: ("Courses"),
          activeColorPrimary: ColorManager.blackColor,
          activeColorSecondary: ColorManager.primaryColor,
          inactiveColorSecondary: ColorManager.blackColor),
      // PersistentBottomNavBarItem(
      //     icon: const Icon(Icons.chrome_reader_mode),
      //     title: ("Quiz"),
      //     activeColorPrimary: ColorManager.blackColor,
      //     activeColorSecondary: ColorManager.primaryColor,
      //     inactiveColorSecondary: ColorManager.blackColor),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite_border),
          title: ("Likes"),
          activeColorPrimary: ColorManager.blackColor,
          activeColorSecondary: ColorManager.primaryColor,
          inactiveColorSecondary: ColorManager.blackColor),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.chat),
      //   title: ("Chat"),
      //     activeColorPrimary: ColorManager.primaryColor,
      //     activeColorSecondary: ColorManager.blackColor,
      //     inactiveColorSecondary: ColorManager.primaryColor
      // ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          activeColorPrimary: ColorManager.blackColor,
          activeColorSecondary: ColorManager.primaryColor,
          inactiveColorSecondary: ColorManager.blackColor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: navScreens(),
      items: _navBarsItems(),
      navBarHeight: 55,
      padding: const NavBarPadding.only(bottom: 2),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(28), topLeft: Radius.circular(20)),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .1),
              blurRadius: 2.0,
              spreadRadius: 5.0,
              offset: Offset(2, 4)),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      stateManagement: false,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 100),
        curve: Curves.bounceOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.bounceOut,
        duration: Duration(milliseconds: 100),
      ),
      navBarStyle: NavBarStyle.style2,
    );
  }
}
