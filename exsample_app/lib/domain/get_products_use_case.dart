import 'package:exsample_app/domain/product_entity.dart';
import 'package:exsample_app/domain/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  Future<List<ProductEntity>> execute() async {
    return await repository.getProducts();
  }
}
