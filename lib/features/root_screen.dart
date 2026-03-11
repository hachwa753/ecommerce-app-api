import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerceappapi/features/carts/presentation/screens/cart_screen.dart';
import 'package:ecommerceappapi/features/products/presentation/screens/cart_page.dart';
import 'package:ecommerceappapi/features/products/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    HomeScreen(),
    CartScreen(),
    Center(child: Text("Settings Page")),
    Center(child: Text("Profile Page")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.deepOrangeAccent,
        color: Colors.deepOrangeAccent,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}
