import 'package:flutter/material.dart';
import 'package:shopping/Screens.dart/categories.dart';
import 'package:shopping/Screens.dart/model.dart';
import 'package:shopping/Screens.dart/notification.dart';
import 'package:shopping/Screens.dart/shoppingCart.dart';

import 'homeScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int mycurrentIndex = 0; 

  List Screens = [
    const HomeScreen(),
    const Categories(),
    const ShoppingCart(),
    const MyOrderPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screens[mycurrentIndex],
        bottomNavigationBar: BottomNavigationBar(
          // elevation: 0,
          currentIndex: mycurrentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: (myNewIndex) => {
            setState(() {
              mycurrentIndex = myNewIndex;
            }),
          },

          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.menu), label: 'Category'),
            BottomNavigationBarItem(
                icon: Badge(
                  textStyle: const TextStyle(fontSize: 12),
                  offset: const Offset(4, -7),
                  label: Text(ShoppingCartItems.length.toString()),
                  child: const Icon(Icons.shopping_cart),
                ),
                label: 'Cart'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Order'),
          ],
        ));
  }
}
