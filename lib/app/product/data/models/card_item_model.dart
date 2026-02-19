import 'package:mini_products_listing_app/app/product/domain/entities/product.dart';

class CardItemModel {
  final Product product;
  int quantity;

  CardItemModel({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}
