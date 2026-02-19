import 'package:flutter_test/flutter_test.dart';
import 'package:mini_products_listing_app/app/product/domain/entities/product_entity.dart';
import 'package:mini_products_listing_app/app/product/presentation/providers/cart_provider.dart';

void main() {
  group('CartProvider', () {
    final product = const ProductEntity(
      id: 1,
      title: 'Test Product',
      description: 'Test',
      image: 'https://example.com/image.png',
      price: 10.0,
    );

    test('adds item to cart and prevents duplicates', () {
      final cart = CartProvider();

      cart.addToCart(product);
      cart.addToCart(product);

      expect(cart.items.length, 1);
      expect(cart.totalItems, 1);
      expect(cart.totalPrice, 10.0);
    });

    test('removes item from cart', () {
      final cart = CartProvider();

      cart.addToCart(product);
      expect(cart.items.isNotEmpty, true);

      cart.removeFromCart(product.id);
      expect(cart.items.isEmpty, true);
      expect(cart.totalItems, 0);
      expect(cart.totalPrice, 0);
    });

    test('increases item quantity', () {
      final cart = CartProvider();

      cart.addToCart(product);
      cart.increaseQuantity(product.id);

      expect(cart.items[product.id]!.quantity, 2);
      expect(cart.totalItems, 1);
      expect(cart.totalPrice, 20.0);
    });

    test('decreases item quantity and removes when it reaches zero', () {
      final cart = CartProvider();

      cart.addToCart(product);
      cart.increaseQuantity(product.id);

      cart.decreaseQuantity(product.id);
      expect(cart.items[product.id]!.quantity, 1);
      expect(cart.totalItems, 1);
      expect(cart.totalPrice, 10.0);

      cart.decreaseQuantity(product.id);
      expect(cart.items.containsKey(product.id), false);
      expect(cart.totalItems, 0);
      expect(cart.totalPrice, 0.0);
    });
  });
}
