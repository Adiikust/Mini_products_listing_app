import 'core/constants/exports.dart';

void main() => runZonedGuarded(
  () async {
    await _init();
    runApp(const MyApp());
  },
  (error, stackTrace) {
    print(error.toString());
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (_) => locator<CartProvider>(),
        ),
      ],
      child: MaterialApp.router(
        title: StringsResource.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData,
        routerConfig: locator<AppRouter>().appRouter,
      ),
    );
  }
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
}
