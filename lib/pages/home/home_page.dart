import 'package:dash/pages/account/account_page.dart';
import 'package:dash/pages/auth/sign_in_page.dart';
import 'package:dash/pages/cart/cart_history.dart';
import 'package:dash/pages/home/main_food_page.dart';
import 'package:dash/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List pages = [
    const MainFoodPage(),
    // Container(
    //   child: Center(
    //     child: Text('History'),
    //   ),
    // ),
    const SignInPage(),
    const CartHistory(),
    const AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'history'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'me'),
        ],
      ),
    );
  }
}
