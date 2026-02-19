import '../../core/constants/exports.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final appRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/${RouteNames.productListPage}',
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteNames.productListPage,
        path: '/${RouteNames.productListPage}',
        builder: (_, state) => ChangeNotifierProvider(
          create: (_) => ProductListProvider(
            getProductsUseCase: locator<GetProductsUseCase>(),
          ),
          child: const ProductListPage(),
        ),
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteNames.productDetailPage,
        path: '/${RouteNames.productDetailPage}',
        builder: (context, state) {
          final args = state.extra as ProductDetailArgs;
          return ProductDetailPage(args: args);
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteNames.cartPage,
        path: '/${RouteNames.cartPage}',
        builder: (_, state) => const CartPage(),
      ),
    ],
  );
}
