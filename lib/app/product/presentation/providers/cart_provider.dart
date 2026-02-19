import '../../../../core/constants/exports.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, CardItemModel> _items = <int, CardItemModel>{};

  Map<int, CardItemModel> get items =>
      Map<int, CardItemModel>.unmodifiable(_items);

  int get totalItems => _items.length;

  double get totalPrice => _items.values.fold<double>(
    0,
    (prev, element) => prev + element.totalPrice,
  );

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      return;
    }
    _items[product.id] = CardItemModel(product: product, quantity: 1);
    notifyListeners();
  }

  //TODO: Increase Item Quantity
  void increaseQuantity(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  //TODO: Decrease Item Quantity
  void decreaseQuantity(int productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity--;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
