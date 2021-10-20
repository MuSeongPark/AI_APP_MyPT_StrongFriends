import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mypt/components/drawer_header_box.dart';
import 'package:mypt/components/video_listview.dart';
import 'package:mypt/screens/community_page.dart';
import 'package:mypt/screens/workout_result_list_page.dart';
import 'package:mypt/screens/leaderboard_demo_page.dart';
import 'package:mypt/screens/login_page.dart';
import 'package:mypt/screens/main_page.dart';
import 'package:mypt/screens/profile_page.dart';
import 'package:get/get.dart';
import 'package:mypt/utils/build_no_title_appbar.dart';

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

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: buildNoTitleAppBar(),
        drawer: _buildDrawer(mediaquery),
        body: _buildIndexedStack(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Drawer _buildDrawer(double mediaquery) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: mediaquery * 0.4,
        child: ListView(
          children: [
            DrawerHeaderBox(name: '현민구'),
            /*
            ListTile(
              leading: Icon(LineAwesomeIcons.user_circle),
              title: Text('Profile'),
              onTap: () {
                Get.to(ProfilePage());
              },
            ),
            */
            ListTile(
              leading: Icon(LineAwesomeIcons.power_off),
              title: Text('로그아웃'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.to(LoginPage());
              },
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
        CommunityPage(),
        LeaderBoardDemoPage(),
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
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.trophy),
          label: 'LeaderBoard',
        ),
      ],
    );
  }
}
