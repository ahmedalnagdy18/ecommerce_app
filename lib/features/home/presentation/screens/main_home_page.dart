import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/home/presentation/screens/cart_page.dart';
import 'package:flutter_application_test/features/home/presentation/screens/bottom_navigation_bar.dart';
import 'package:flutter_application_test/features/explore/presentation/screens/explore_page.dart';
import 'package:flutter_application_test/features/home/presentation/screens/home_page.dart';
import 'package:flutter_application_test/features/home/presentation/screens/my_profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.name});
  final List? name;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> screens = [];
  int selectedIndex = 0;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
    screens.addAll([
      const MyHomepage(),
      const AddToCart(),
      const ExplorePage(),
      const MyProfilePage(),
    ]);
  }

  Future<void> _checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _hasInternet = true;
        });
      } else {
        setState(() {
          _hasInternet = false;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _hasInternet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _hasInternet
          ? screens.elementAt(selectedIndex)
          : const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    SizedBox(height: 8),
                    Text(
                        textAlign: TextAlign.center,
                        'No internet connection \n Please check your connection.'),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      selectedIndex = value;
    });
  }
}
