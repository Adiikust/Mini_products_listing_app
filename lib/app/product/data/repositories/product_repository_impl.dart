import 'package:mini_products_listing_app/app/product/data/datasources/product_remote_data_source.dart';
import 'package:mini_products_listing_app/app/product/domain/repositories/product_repository.dart';
import '../../../../core/constants/exports.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final List<ProductModel> models = await remoteDataSource.fetchProducts();
      return models
          .map(
            (m) => Product(
              id: m.id,
              title: m.title,
              description: m.description,
              image: m.image,
              price: m.price,
            ),
          )
          .toList();
    } on Failure {
      rethrow;
    } catch (_) {
      throw UnknownFailure('Unexpected error occurred');
    }
  }
}
