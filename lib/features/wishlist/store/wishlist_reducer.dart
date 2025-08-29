import 'wishlist_actions.dart';
import 'wishlist_state.dart';
import '../domain/models/wishlist_item.dart';

WishlistState wishlistReducer(WishlistState state, dynamic action) {
  if (action is AddToWishlist) {
    // Check if product is already in wishlist
    if (state.containsProduct(action.product.id!)) {
      return state; // Already exists, return current state
    }

    final newItem = WishlistItem(
      product: action.product,
      addedAt: DateTime.now(),
    );

    return state.copyWith(
      items: [...state.items, newItem],
      error: null, // Clear any previous errors
    );
  }

  if (action is RemoveFromWishlist) {
    final updatedItems = state.items
        .whereType<WishlistItem>()
        .where((item) => item.product.id != action.productId)
        .toList();

    return state.copyWith(items: updatedItems, error: null);
  }

  if (action is ToggleWishlist) {
    if (state.containsProduct(action.product.id!)) {
      // Remove if exists
      return wishlistReducer(state, RemoveFromWishlist(action.product.id!));
    } else {
      // Add if doesn't exist
      return wishlistReducer(state, AddToWishlist(action.product));
    }
  }

  if (action is ClearWishlist) {
    return state.copyWith(items: [], error: null);
  }

  if (action is LoadWishlist) {
    return state.copyWith(items: action.items, error: null);
  }

  if (action is SetWishlistLoading) {
    return state.copyWith(isLoading: action.isLoading);
  }

  if (action is SetWishlistError) {
    return state.copyWith(error: action.error);
  }

  return state;
}
