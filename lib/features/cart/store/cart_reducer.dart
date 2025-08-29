import 'cart_state.dart';
import 'cart_actions.dart';
import '../domain/models/cart_item.dart';

CartState cartReducer(CartState state, dynamic action) {
  if (action is AddToCart) {
    // Check if product is already in cart
    final existingItemIndex = state.items.indexWhere(
      (item) => item.product.id == action.product.id,
    );

    if (existingItemIndex != -1) {
      // Update quantity if product exists
      final updatedItems = List<CartItem>.from(state.items);
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + action.quantity,
      );

      return state.copyWith(items: updatedItems, error: null);
    } else {
      // Add new item if product doesn't exist
      final newItem = CartItem(
        product: action.product,
        quantity: action.quantity,
        addedAt: DateTime.now(),
      );

      return state.copyWith(items: [...state.items, newItem], error: null);
    }
  }

  if (action is RemoveFromCart) {
    final updatedItems = state.items
        .where((item) => item.product.id != action.productId)
        .toList();

    return state.copyWith(items: updatedItems, error: null);
  }

  if (action is UpdateCartItemQuantity) {
    if (action.quantity <= 0) {
      // Remove item if quantity is 0 or negative
      return cartReducer(state, RemoveFromCart(action.productId));
    }

    final updatedItems = state.items.map((item) {
      if (item.product.id == action.productId) {
        return item.copyWith(quantity: action.quantity);
      }
      return item;
    }).toList();

    return state.copyWith(items: updatedItems, error: null);
  }

  if (action is ClearCart) {
    return state.copyWith(items: [], error: null);
  }

  if (action is LoadCart) {
    return state.copyWith(items: action.items, error: null);
  }

  if (action is SetCartLoading) {
    return state.copyWith(isLoading: action.isLoading);
  }

  if (action is SetCartError) {
    return state.copyWith(error: action.error);
  }

  return state;
}
