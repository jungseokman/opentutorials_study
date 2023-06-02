import 'dart:convert';

import './product_model.dart';
import 'package:http/http.dart' as http;

// abstract class ProductDataSource {
//   Future<List<ProductModel>> getProducts();
// }

// class ProductApiDataSource implements ProductDataSource {
//   final String apiUrl;

//   ProductApiDataSource({required this.apiUrl});

//   @override
//   Future<List<ProductModel>> getProducts() async {
//     final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       final List<ProductModel> products = data
//           .map((dynamic json) => ProductModel.fromJson(json))
//           .toList() as List<ProductModel>;

//       return products;
//     } else {
//       throw Exception('Failed to retrieve products');
//     }
//   }
// }

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductDataSourceImpl implements ProductDataSource {
  final http.Client client;

  ProductDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse(
        'https://fakestoreapi.com/products')); // assuming this is the API endpoint for retrieving product data
    if (response.statusCode == 200) {
      final List<dynamic> productsJson = jsonDecode(response.body);
      return productsJson.map((json) => ProductModel.fromJson(json)).toList()
          as Future<List<ProductModel>>;

      print(productsJson);
      print('object');
    } else {
      throw Exception('Failed to load products');
    }
  }
}
