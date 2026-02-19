import 'package:http/http.dart' as http;
import 'package:mini_products_listing_app/app/product/data/datasources/product_remote_data_source.dart';
import 'package:mini_products_listing_app/app/product/data/repositories/product_repository_impl.dart';
import 'package:mini_products_listing_app/app/product/domain/repositories/product_repository.dart';

import '../constants/exports.dart';

Future<void> initDependencies() async {
  /// Route
  locator.registerLazySingleton<AppRouter>(() => AppRouter());

  /// External
  locator.registerLazySingleton<http.Client>(() => http.Client());

  /// Data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: locator<http.Client>()),
  );

  /// Repositories
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator<ProductRemoteDataSource>(),
    ),
  );

  /// Use cases
  locator.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(repository: locator<ProductRepository>()),
  );

  /// Providers
  locator.registerLazySingleton<CartProvider>(() => CartProvider());
}
