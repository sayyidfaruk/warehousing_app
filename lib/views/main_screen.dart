import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import './product_screen.dart';
import './sales_screen.dart';
import './stock_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    StockScreen(),
    ProductScreen(),
    SalesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 105, 165, 255),
      appBar: AppBar(
        title: Text('Bakery Warehouse'),
        backgroundColor: Color.fromARGB(255, 105, 165, 255), // Pink color
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: GNav(
        rippleColor: const Color.fromARGB(255, 255, 255, 255)!,
        hoverColor: Color.fromARGB(255, 255, 255, 255)!,
        gap: 8,
        activeColor: Color(0xFF000000),
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: const Color.fromRGBO(99, 154, 166, 1)!,
        color: const Color.fromRGBO(156, 206, 217, 1),
        tabs: [
          GButton(
            icon: Icons.inventory,
            text: 'Stocks',
          ),
          GButton(
            icon: Icons.cake,
            text: 'Product',
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Sales',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
