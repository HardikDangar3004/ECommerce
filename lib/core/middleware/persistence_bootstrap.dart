import 'package:redux/redux.dart';

import '../../features/cart/store/cart_actions.dart';
import '../../features/wishlist/store/wishlist_actions.dart';
import '../di/service_locator.dart';
import '../store/app_state.dart';

/// Loads persisted cart and wishlist into the store on app startup.
Future<void> bootstrapPersistence(Store<AppState> store) async {
  final storage = ServiceLocator.localStorageService;
  final cartItems = await storage.loadCartItems();
  final wishlistItems = await storage.loadWishlistItems();

  if (cartItems.isNotEmpty) {
    store.dispatch(LoadCart(cartItems));
  }
  if (wishlistItems.isNotEmpty) {
    store.dispatch(LoadWishlist(wishlistItems));
  }
}
