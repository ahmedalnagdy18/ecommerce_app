import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/home/presentation/screens/add_to_cart.dart';
import 'package:flutter_application_test/features/home/presentation/screens/bottom_navigation_bar.dart';
import 'package:flutter_application_test/features/home/presentation/screens/explore_page.dart';
import 'package:flutter_application_test/features/home/presentation/screens/home_page.dart';
import 'package:flutter_application_test/features/home/presentation/screens/my_profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.name});
  final List? name;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List name = [];
  int selectedindex = 0;

  @override
  void initState() {
    name.addAll([
      const MyHomepage(),
      const AddToCart(),
      const ExplorePage(),
      const MyProfilePage(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: name.elementAt(selectedindex),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentIndex: selectedindex,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int value) {
    setState(() {
      selectedindex = value;
    });
  }
}
