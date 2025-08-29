
import 'package:equatable/equatable.dart';
import '../../features/auth/store/auth_state.dart';
import '../../features/cart/store/cart_state.dart';
import '../../features/product/store/product_state.dart';
import '../../features/wishlist/store/wishlist_state.dart';

class AppState extends Equatable {
  final bool isDarkMode;
  final AuthState authState;
  final ProductState productState;
  final CartState cartState;
  final WishlistState wishlistState;

  const AppState({
    required this.isDarkMode,
    required this.authState,
    required this.productState,
    required this.cartState,
    required this.wishlistState,
  });

  factory AppState.initial() {
    return const AppState(
      isDarkMode: false,
      authState: AuthState(),
      productState: ProductState(),
      cartState: CartState(),
      wishlistState: WishlistState(),
    );
  }

  AppState copyWith({
    bool? isDarkMode,
    AuthState? authState,
    ProductState? productState,
    CartState? cartState,
    WishlistState? wishlistState,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      authState: authState ?? this.authState,
      productState: productState ?? this.productState,
      cartState: cartState ?? this.cartState,
      wishlistState: wishlistState ?? this.wishlistState,
    );
  }

  @override
  List<Object?> get props => [
    isDarkMode,
    authState,
    productState,
    cartState,
    wishlistState,
  ];
}
