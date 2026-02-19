import '../../../../core/constants/exports.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
