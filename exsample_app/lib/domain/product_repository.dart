import 'package:exsample_app/data/product_model.dart';
import '../data/product_data_source.dart';
import './product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<List<ProductEntity>> getProducts() async {
    final List<ProductModel> productModels = await dataSource.getProducts();
    final List<ProductEntity> productEntities =
        productModels.map((ProductModel productModel) {
      return ProductEntity(
        id: productModel.id,
        name: productModel.name,
        description: productModel.description,
        price: productModel.price,
        imageUrl: productModel.imageUrl,
      );
    }).toList();

    return productEntities;
  }
}
