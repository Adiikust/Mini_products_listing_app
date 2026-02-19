import 'package:flutter_test/flutter_test.dart';
import 'package:mini_products_listing_app/core/enums/product_list_status.dart';
import 'package:mini_products_listing_app/app/product/domain/entities/product_entity.dart';
import 'package:mini_products_listing_app/app/product/domain/usecases/get_products_use_case.dart';
import 'package:mini_products_listing_app/app/product/domain/repositories/product_repository.dart';
import 'package:mini_products_listing_app/app/product/presentation/providers/product_list_provider.dart';
import 'package:mini_products_listing_app/core/constants/global_variables.dart';
import 'package:mini_products_listing_app/core/use_case/use_case.dart';

class FakeProductRepositorySuccess implements ProductRepository {
  @override
  Future<List<ProductEntity>> getProducts() async {
    return const [
      ProductEntity(
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
  Future<List<ProductEntity>> getProducts() async {
    return <ProductEntity>[];
  }
}

class FakeGetProductsUseCaseSuccess extends GetProductsUseCase
    implements UseCase<List<ProductEntity>, void> {
  FakeGetProductsUseCaseSuccess()
    : super(repository: FakeProductRepositorySuccess());

  @override
  Future<List<ProductEntity>> call({void params}) async {
    return const [
      ProductEntity(
        id: 1,
        title: 'Test Product',
        description: 'Test',
        image: 'https://example.com/image.png',
        price: 20.0,
      ),
    ];
  }
}

class FakeGetProductsUseCaseEmpty extends GetProductsUseCase {
  FakeGetProductsUseCaseEmpty()
    : super(repository: FakeProductRepositoryEmpty());

  @override
  Future<List<ProductEntity>> call({void params}) async {
    return <ProductEntity>[];
  }
}

void main() {
  setUp(() {
    if (locator.isRegistered<GetProductsUseCase>()) {
      locator.unregister<GetProductsUseCase>();
    }
  });

  tearDown(() {
    if (locator.isRegistered<GetProductsUseCase>()) {
      locator.unregister<GetProductsUseCase>();
    }
  });

  group('ProductListProvider', () {
    test('loads products successfully', () async {
      locator.registerLazySingleton<GetProductsUseCase>(
        () => FakeGetProductsUseCaseSuccess(),
      );

      final provider = ProductListProvider();

      await provider.loadProducts();

      expect(provider.status, ProductListStatus.loaded);
      expect(provider.products.length, 1);
    });

    test('handles empty products', () async {
      locator.registerLazySingleton<GetProductsUseCase>(
        () => FakeGetProductsUseCaseEmpty(),
      );

      final provider = ProductListProvider();

      await provider.loadProducts();

      expect(provider.status, ProductListStatus.empty);
      expect(provider.products.isEmpty, true);
    });
  });
}
