import 'package:redux/redux.dart';

import '../../features/cart/store/cart_actions.dart';
import '../../features/wishlist/store/wishlist_actions.dart';
import '../services/local_storage_service.dart';
import '../store/app_state.dart';

class PersistenceMiddleware extends MiddlewareClass<AppState> {
  final LocalStorageService localStorageService;

  PersistenceMiddleware(this.localStorageService);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    // Persist Cart on changes
    if (action is AddToCart ||
        action is RemoveFromCart ||
        action is UpdateCartItemQuantity ||
        action is ClearCart ||
        action is LoadCart) {
      await localStorageService.saveCartItems(store.state.cartState.items);
    }

    // Persist Wishlist on changes
    if (action is AddToWishlist ||
        action is RemoveFromWishlist ||
        action is ToggleWishlist ||
        action is ClearWishlist ||
        action is LoadWishlist) {
      await localStorageService.saveWishlistItems(
        store.state.wishlistState.items,
      );
    }
  }
}
