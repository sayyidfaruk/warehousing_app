import 'package:flutter/material.dart';
import 'package:warehousing_app/views/add/add_stock.dart';
import './product_screen.dart';
import './sales_screen.dart';
import './stock_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<bool> _stockUpdateNotifier = ValueNotifier<bool>(false);

  static List<Widget> _widgetOptions(ValueNotifier<bool> notifier) => <Widget>[
    StockScreen(updateNotifier: notifier),
    ProductScreen(),
    SalesScreen(),
  ];

  Future<void> navigateToAddStock() async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStock(),
      ),
    );

    if (result == true) {
      _stockUpdateNotifier.value = !_stockUpdateNotifier.value; // Memicu pembaruan
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bakery Warehouse'),
          bottom: TabBar(tabs: [
            Tab(text: 'Stocks'),
            Tab(text: 'Products'),
            Tab(text: 'Sales'),
          ]),
        ),
        body: TabBarView(
          children: _widgetOptions(_stockUpdateNotifier),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: navigateToAddStock,
          tooltip: 'Add Stock',
          child: Icon(Icons.add, color: Colors.white,),
        ),
      ),
    );
  }
}
