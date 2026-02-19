import '../../../../core/constants/exports.dart';

class ProductListProvider extends ChangeNotifier {
  final _getProductsUseCase = locator<GetProductsUseCase>();

  ProductListStatus _status = ProductListStatus.initial;
  List<ProductEntity> _products = <ProductEntity>[];
  String? _errorMessage;

  ProductListStatus get status => _status;
  List<ProductEntity> get products => _products;
  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    _status = ProductListStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _getProductsUseCase();
      if (result.isEmpty) {
        _status = ProductListStatus.empty;
        _products = <ProductEntity>[];
      } else {
        _status = ProductListStatus.loaded;
        _products = result;
      }
    } on Failure catch (failure) {
      _status = ProductListStatus.error;
      _errorMessage = failure.message;
    } catch (_) {
      _status = ProductListStatus.error;
      _errorMessage = StringsResource.somethingWentWrong;
    }
    notifyListeners();
  }
}
