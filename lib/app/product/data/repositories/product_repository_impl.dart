import 'package:mini_products_listing_app/app/product/data/datasources/product_remote_data_source.dart';
import 'package:mini_products_listing_app/app/product/domain/repositories/product_repository.dart';
import '../../../../core/constants/exports.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final List<ProductModel> products = await remoteDataSource
          .fetchProducts();
      return products
          .map(
            (product) => ProductEntity(
              id: product.id,
              title: product.title,
              description: product.description,
              image: product.image,
              price: product.price,
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
