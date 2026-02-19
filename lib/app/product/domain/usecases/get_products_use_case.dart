import '../../../../core/constants/exports.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase implements UseCase<List<ProductEntity>, void> {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<List<ProductEntity>> call({void params}) async {
    try {
      return await repository.getProducts();
    } on Failure {
      rethrow;
    } catch (_) {
      throw UnknownFailure('Unexpected error occurred');
    }
  }
}
