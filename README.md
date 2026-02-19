## mini_products_listing_app

A simple mini products listing Flutter application that displays a list of products,
allows adding/removing them from a cart, and demonstrates clean architecture with
basic state management using `ChangeNotifier` and the provider pattern.

---

## Setup instructions

- **Prerequisites**
  - **Flutter**: Make sure Flutter SDK (3.x or later) is installed and added to your PATH.
  - **Platform tools**: Android Studio / Xcode (depending on your target platform).

- **Clone & install dependencies**
  - Clone the repository and navigate into the project root:
    - `cd mini_products_listing_app`
  - Fetch Dart/Flutter dependencies:
    - `flutter pub get`

- **Run the app**
  - On an emulator or connected device:
    - `flutter run`

- **Run tests**
  - All tests:
    - `flutter test`
  - Individual test files:
    - `flutter test test/cart_provider_test.dart`
    - `flutter test test/product_list_provider_test.dart`

---

## Architecture explanation

- **Overall approach**
  - **Clean-ish layered structure** with clear separation of concerns:
    - `app/` – Feature modules (e.g. `product`) combining presentation, domain, and data parts.
    - `core/` – Reusable, app-wide pieces (enums, constants, error handling, use case abstractions, utils, etc.).
    - `config/` – App-level wiring such as router and theme configuration.

- **Layers**
  - **Domain layer**
    - Contains business logic and pure Dart entities:
      - `Product` entity in `app/product/domain/entities`.
      - Use case `GetProductsUseCase` in `app/product/domain/usecases`.
      - `ProductRepository` abstraction in `app/product/domain/repositories`.
  - **Data layer**
    - Contains implementation details for fetching products and models specific to data/storage:
      - `CardItemModel` in `app/product/data/models` for cart items.
      - (Other repository implementations would live under `app/product/data/`).
  - **Presentation layer**
    - Contains UI widgets and state providers:
      - `ProductListProvider` and `CartProvider` in `app/product/presentation/providers`.
      - Screens and widgets under `app/product/presentation/...`.

- **Navigation & configuration**
  - `config/router` holds route definitions and navigation setup.
  - `config/theme` defines light/dark themes and shared styling used across the app.

---

## State management explanation

- **Pattern used**
  - The app uses **`ChangeNotifier` + Provider-style** state management.
  - Each major feature has its own provider class in `presentation/providers`.

- **`ProductListProvider`**
  - Responsible for loading and exposing the list of products.
  - Depends on `GetProductsUseCase` (injected in the constructor).
  - Exposes:
    - `status: ProductListStatus` – `initial`, `loading`, `loaded`, `empty`, or `error`.
    - `products: List<Product>` – the list rendered by the UI.
    - `errorMessage: String?` – human-readable error text when loading fails.
  - Method `loadProducts()`:
    - Sets status to `loading`, then calls `getProductsUseCase()`.
    - Updates status to `loaded` with products, `empty` if list is empty, or `error` on failure.
    - Notifies listeners so the UI can rebuild appropriately.

- **`CartProvider`**
  - Manages the shopping cart contents.
  - Internal storage:
    - `Map<int, CardItemModel> _items` keyed by product id.
  - Exposes:
    - `items` (unmodifiable view of the cart map).
    - `totalItems` (number of distinct products).
    - `totalPrice` (sum of each `CardItemModel.totalPrice`).
  - Key methods:
    - `addToCart(Product product)` – adds an item with quantity `1`, preventing duplicates.
    - `increaseQuantity(int productId)` – increments quantity and notifies listeners.
    - `decreaseQuantity(int productId)` – decrements quantity, and removes the item if it reaches `0`.
    - `removeFromCart(int productId)` – removes an item completely from the cart.

---

## Assumptions

- **Data & API**
  - Products are assumed to be fetched via `ProductRepository.getProducts()`, which returns a simple list of `Product` entities.
  - For tests, fake repositories (`FakeProductRepositorySuccess`, `FakeProductRepositoryEmpty`) are used to simulate responses.
  - Error handling is done via `Failure` types and a generic `UnknownFailure` for unexpected errors.

- **UI & UX**
  - The app focuses on **basic product listing and cart manipulation**, not on full checkout/payment flows.
  - No persistent storage is assumed; cart state is in-memory only and is reset when the app restarts.
  - Images and prices are treated as trusted data (no special formatting/validation beyond what is shown).

- **Architecture**
  - Only a subset of **Clean Architecture** is implemented for simplicity:
    - Single repository per main feature (product).
    - Single primary use case (`GetProductsUseCase`) as an example.
  - Network layer / local cache layers (if present) are abstracted away behind the repository.

---

## Possible improvements

- **Architecture & code quality**
  - Add full repository implementations (remote data sources, caching) and wire them with dependency injection.
  - Introduce a proper DI solution (e.g. `get_it`) instead of manual wiring in `main.dart`.
  - Expand use-case layer with more operations (e.g. search, filter, pagination).

- **State management**
  - Migrate to a more scalable solution for larger apps:
    - e.g. `Riverpod`, `Bloc`, or `Cubit` while keeping the same domain layer.
  - Add more granular state classes to better represent loading/error per section of the UI.

- **Testing**
  - Increase unit test coverage for:
    - Presentation logic (edge cases in `ProductListProvider` and `CartProvider`).
    - Repository implementations with mocked data sources.
  - Add widget tests for screens (product list, product details, cart view).

- **User experience**
  - Improve error handling in the UI (retry buttons, empty/error illustrations).
  - Add filtering/sorting options for products.
  - Add localization support and better theming (e.g. custom typography, colors, dark mode).

- **Performance & robustness**
  - Cache product results to reduce API calls.
  - Handle offline scenarios gracefully (show cached data or explicit offline state).

