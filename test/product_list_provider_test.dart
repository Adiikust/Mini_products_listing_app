import 'package:flutter_test/flutter_test.dart';
import 'package:mini_products_listing_app/core/enums/product_list_status.dart';
import 'package:mini_products_listing_app/app/product/domain/entities/product.dart';
import 'package:mini_products_listing_app/app/product/domain/usecases/get_products_use_case.dart';
import 'package:mini_products_listing_app/app/product/domain/repositories/product_repository.dart';
import 'package:mini_products_listing_app/app/product/presentation/providers/product_list_provider.dart';

class FakeProductRepositorySuccess implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    return const [
      Product(
        id: 1,
        title: 'Test Product',
        description: 'Test',
        image: 'https://example.com/image.png',
        price: 20.0,
      ),
    ];
  }
}

class FakeProductRepositoryEmpty implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    return <Product>[];
  }
}

void main() {
  group('ProductListProvider', () {
    test('loads products successfully', () async {
      final provider = ProductListProvider(
        getProductsUseCase: GetProductsUseCase(
          repository: FakeProductRepositorySuccess(),
        ),
      );

      await provider.loadProducts();

      expect(provider.status, ProductListStatus.loaded);
      expect(provider.products.length, 1);
    });

    test('handles empty products', () async {
      final provider = ProductListProvider(
        getProductsUseCase: GetProductsUseCase(
          repository: FakeProductRepositoryEmpty(),
        ),
      );

      await provider.loadProducts();

      expect(provider.status, ProductListStatus.empty);
      expect(provider.products.isEmpty, true);
    });
  });
}
