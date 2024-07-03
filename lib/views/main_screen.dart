import 'package:flutter/material.dart';
import 'package:warehousing_app/views/add/add_product.dart';
import 'package:warehousing_app/views/add/add_sales.dart';
import 'package:warehousing_app/views/add/add_stock.dart';
import './product_screen.dart';
import './sales_screen.dart';
import './stock_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _stockUpdateNotifier = ValueNotifier<bool>(false);
  TabController? _tabController;

  static List<Widget> _widgetOptions(ValueNotifier<bool> notifier) => <Widget>[
    StockScreen(updateNotifier: notifier),
    ProductScreen(updateNotifier: notifier,),
    SalesScreen(updateNotifier: notifier),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> navigateToAdd() async {
    bool? result;
    if (_tabController?.index == 0) {
      result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddStock(),
        ),
      );
    } else if (_tabController?.index == 1) {
      result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddProduct(),
        ),
      );
    } else if (_tabController?.index == 2) {
      result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddSale(),
        ),
      );
    }

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
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Stocks'),
              Tab(text: 'Products'),
              Tab(text: 'Sales'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _widgetOptions(_stockUpdateNotifier),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: navigateToAdd,
          tooltip: 'Add',
          child: Icon(Icons.add, color: Colors.white,),
        ),
      ),
    );
  }
}
