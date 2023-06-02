import 'package:exsample_app/data/product_data_source.dart';
import 'package:exsample_app/domain/get_products_use_case.dart';
import 'package:exsample_app/domain/product_entity.dart';
import 'package:exsample_app/domain/product_repository.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProductRepositoryImpl productRepository = ProductRepositoryImpl(
    dataSource: ProductDataSourceImpl(
      client: http.Client(),
    ),
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: FutureBuilder<List<ProductEntity>>(
          future: GetProductsUseCase(repository: productRepository).execute(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<ProductEntity> products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    leading: Image.network(product.imageUrl),
                    trailing: Text('\$${product.price}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
