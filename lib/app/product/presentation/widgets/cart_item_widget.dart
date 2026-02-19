import '../../../../core/constants/exports.dart';

class CartItemWidget extends StatelessWidget {
  final ProductEntity product;
  final int quantity;

  const CartItemWidget({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.image,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image),
        ),
      ),
      title: TextViewWidget(
        product.title,
        maxLines: 1,
        isEllipsis: true,
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),

      subtitle: Text('Qty: $quantity • \$${product.price.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () {
              if (quantity > 1) {
                cart.decreaseQuantity(product.id);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(StringsResource.quantityCannotLessThenOne),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),

          Text(
            '$quantity',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => cart.increaseQuantity(product.id),
          ),

          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => cart.removeFromCart(product.id),
          ),
        ],
      ),
    );
  }
}
