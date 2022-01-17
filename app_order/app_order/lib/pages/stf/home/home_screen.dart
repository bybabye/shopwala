import 'package:app_order/pages/stf/category/category_page.dart';
import 'package:app_order/pages/stf/home/home.dart';

import 'package:app_order/pages/stf/profile/profile_page.dart';
import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthencationProvider auth;
  int indexPage = 0;

  List<Widget> pages = [
    const Home(),
    const CategoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthencationProvider>(context);

    return Scaffold(
      body: pages[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: indexPage,
        selectedItemColor: AppColor.kButtonSecondColor,
        onTap: (_index) {
          setState(() {
            indexPage = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Trang chủ",
            icon: Icon(
              Icons.home_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "Danh mục",
            icon: Icon(Icons.category_outlined),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.account_circle,
            ),
          ),
        ],
      ),
    );
  }
}
