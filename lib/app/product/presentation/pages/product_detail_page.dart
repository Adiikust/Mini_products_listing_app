import '../../../../core/constants/exports.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductDetailArgs args;

  const ProductDetailPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final product = args.product;
    final cart = context.watch<CartProvider>();
    final isInCart = cart.items.containsKey(product.id);

    return Scaffold(
      appBar: AppBar(title: const Text(StringsResource.productDetail)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  height: 260,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 96),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextViewWidget(
              product.title,
              maxLines: 2,
              isEllipsis: true,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            TextViewWidget(
              '\$${product.price.toStringAsFixed(2)}',
              maxLines: 1,
              isEllipsis: true,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.indigo,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),
            TextViewWidget(
              product.description,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: isInCart ? null : () => cart.addToCart(product),
            icon: const Icon(Icons.add_shopping_cart),
            label: Text(
              isInCart
                  ? StringsResource.alreadyInCart
                  : StringsResource.addToCart,
            ),
          ),
        ),
      ),
    );
  }
}
