import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mypt/components/drawer_header_box.dart';
import 'package:mypt/screens/category_list_page.dart';
import 'package:mypt/screens/leaderboard_page.dart';
import 'package:mypt/screens/main_page.dart';
import 'package:mypt/screens/profile_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(mediaquery),
      body: _buildIndexedStack(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MyPT',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 36,
            ),
          ),
          SizedBox(width: 5),
          Icon(LineAwesomeIcons.dumbbell),
        ],
      ),
      centerTitle: true,
    );
  }

  Drawer _buildDrawer(double mediaquery) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: mediaquery * 0.4,
        child: ListView(
          children: [
            DrawerHeaderBox(name: 'Jongin Jun'),
            ListTile(
              leading: Icon(LineAwesomeIcons.user_circle),
              title: Text('Profile'),
              onTap: () {
                Get.to(ProfilePage());
              },
            ),
            ListTile(
              leading: Icon(LineAwesomeIcons.power_off),
              title: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndexedStack() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        MainPage(),
        CategoryListPage(),
        LeaderBoardPage(),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.home),
          label: 'Main page',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.stream),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.trophy),
          label: 'LeaderBoard',
        ),
      ],
    );
  }
}
