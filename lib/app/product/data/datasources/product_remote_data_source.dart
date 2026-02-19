import 'package:http/http.dart' as http;
import '../../../../core/constants/exports.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final uri = Uri.parse(ConstantsResource.products);
    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as List<dynamic>;
        return decoded
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerFailure('Server error: ${response.statusCode}');
      }
    } on Failure {
      rethrow;
    } on http.ClientException catch (e) {
      throw NetworkFailure('Network error: ${e.message}');
    } catch (_) {
      throw UnknownFailure('Unexpected error occurred');
    }
  }
}
