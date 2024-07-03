import 'dart:convert';

import 'package:warehousing_app/models/sales_model.dart';
import 'package:http/http.dart' as http;

class SalesController {
  final String url = 'https://api.kartel.dev/products';

  Future<List<Sales>> fetchProducts() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Sales> products = data.map((json) => Sales.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<http.Response> postData(
    {required String name,
    required num price,
    required int qty,
    required String attr,
    required int weight,
    required String issuer}) async {
    var response = await http.post(Uri.parse(url), 
    headers: {
      'Content-Type': 'application/json',
    },

    body: jsonEncode({
      'name': name,
      'price': price,
      'qty': qty,
      'attr': attr,
      'weight': weight,
      'issuer': issuer,
    }));

    return response;
  }

  Future<http.Response> updateProduct(
    {required String id,
    required num price,
    required String name,
    required int qty,
    required String attr,
    required int weight,
    required String issuer}) async {
    var response = await http.put(Uri.parse('$url/$id'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'name': name,
      'price': price,
      'qty': qty,
      'attr': attr,
      'weight': weight,
      'issuer': issuer,
    }));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    var response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode != 204){
      throw Exception('Failed to delete product:$id');
    }
  }
}
