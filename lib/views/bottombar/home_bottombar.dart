
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:topgrade/utils/color_manager.dart';

import '../screens/chat/chat_screen.dart';
import '../screens/courses/my_courses_screen.dart';
import '../screens/favourites/favourites_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';


class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {

  var _currentIndex = 0;
  List<Widget> tabs = [
    HomeScreen(),
    const MyCoursesScreen(),
    const FavouritesScreen(),
    const ChatScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: ColorManager.primaryColor,
          ),

          /// My Courses
          SalomonBottomBarItem(
            icon: const Icon(Icons.description),
            title: const Text("My Courses"),
            selectedColor: ColorManager.primaryColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text("Likes"),
            selectedColor: ColorManager.primaryColor,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.chat),
            title: const Text("Chat"),
            selectedColor: ColorManager.primaryColor,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: ColorManager.primaryColor,
          ),
        ],
      ),
    );
  }
}
