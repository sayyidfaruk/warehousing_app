import 'package:flutter/material.dart';
import 'package:warehousing_app/models/stock_model.dart';
import 'package:warehousing_app/controllers/stock_controller.dart';

class StockScreen extends StatefulWidget {
  final ValueNotifier<bool> updateNotifier;

  StockScreen({required this.updateNotifier});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  late Future<List<Stock>> futureStocks;
  final StockController _stockController = StockController();

  @override
  void initState() {
    super.initState();
    futureStocks = _stockController.fetchStocks();
    widget.updateNotifier.addListener(_fetchData);
  }

  @override
  void dispose() {
    widget.updateNotifier.removeListener(_fetchData);
    super.dispose();
  }

  void _fetchData() {
    setState(() {
      futureStocks = _stockController.fetchStocks();
    });
  }

  void _deleteStock(String id) async {
    try {
      await _stockController.deleteStock(id);
      _fetchData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus stok: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.updateNotifier,
      builder: (context, value, child) {
        return Container(
          child: Center(
            child: FutureBuilder<List<Stock>>(
              future: futureStocks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<Stock> stocks = snapshot.data!;
                  List<Stock> filteredStocks =
                      stocks.where((stock) => stock.issuer == 'sayyid').toList();
                  return ListView.builder(
                    itemCount: filteredStocks.length,
                    itemBuilder: (context, index) {
                      Stock stock = filteredStocks[index];
                      return Container(
                        margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[200],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(stock.name),
                          subtitle: Text('Quantity: ${stock.qty.toString()} ${stock.attr}'),
                          trailing: IconButton(
                            onPressed: () => _deleteStock(stock.id),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.only(right: 5, left: 15),
                        ),
                      );
                    },
                  );
                }
                return Text('Tidak ada data');
              },
            ),
          ),
        );
      },
    );
  }
}
