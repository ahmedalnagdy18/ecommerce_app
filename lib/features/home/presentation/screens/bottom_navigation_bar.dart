import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget(
      {super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final dynamic Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return CustomLineIndicatorBottomNavbar(
      unselectedIconSize: 20,
      selectedIconSize: 20,
      selectedColor: Colors.black,
      unSelectedColor: Colors.black54,
      backgroundColor: Colors.white,
      enableLineIndicator: true,
      lineIndicatorWidth: 5,
      indicatorType: IndicatorType.Top,
      customBottomBarItems: [
        CustomBottomBarItems(
          label: 'Home',
          icon: Icons.home_max_outlined,
        ),
        CustomBottomBarItems(icon: Icons.shopping_cart_outlined, label: 'Cart'),
        CustomBottomBarItems(
          label: 'Explore',
          icon: Icons.explore,
        ),
        CustomBottomBarItems(
          label: 'Profile',
          icon: Icons.person_outlined,
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
