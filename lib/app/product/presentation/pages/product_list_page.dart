import '../../../../core/constants/exports.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductListProvider>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsResource.products),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => context.pushNamed(RouteNames.cartPage),
              ),
              if (cart.totalItems > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      cart.totalItems.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Consumer<ProductListProvider>(
        builder: (context, provider, _) {
          Widget content;
          switch (provider.status) {
            case ProductListStatus.loading:
              content = const Center(child: CircularProgressIndicator());
              break;
            case ProductListStatus.error:
              content = Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        provider.errorMessage ??
                            StringsResource.failedToLoadProducts,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: provider.loadProducts,
                        child: const Text(StringsResource.retry),
                      ),
                    ],
                  ),
                ),
              );
              break;
            case ProductListStatus.empty:
              content = const Center(
                child: Text(StringsResource.noProductsFound),
              );
              break;
            case ProductListStatus.loaded:
              content = ListView.builder(
                itemCount: provider.products.length,
                itemBuilder: (context, index) {
                  final product = provider.products[index];
                  return ProductCardWidget(
                    product: product,
                    onTap: () => context.pushNamed(
                      RouteNames.productDetailPage,
                      extra: ProductDetailArgs(product: product),
                    ),
                  );
                },
              );
              break;
            case ProductListStatus.initial:
              content = const SizedBox.shrink();
              break;
          }

          return RefreshIndicator(
            onRefresh: provider.loadProducts,
            child: provider.status == ProductListStatus.loaded
                ? content
                : ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: content,
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
