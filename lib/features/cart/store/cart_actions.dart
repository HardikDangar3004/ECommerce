import '../../product/domain/models/product.dart';
import '../domain/models/cart_item.dart';

// Add product to cart
class AddToCart {
  final Product product;
  final int quantity;
  AddToCart(this.product, {this.quantity = 1});
}

// Remove product from cart
class RemoveFromCart {
  final int productId;
  RemoveFromCart(this.productId);
}

// Update product quantity in cart
class UpdateCartItemQuantity {
  final int productId;
  final int quantity;
  UpdateCartItemQuantity(this.productId, this.quantity);
}

// Clear all cart items
class ClearCart {}

// Load cart from storage
class LoadCart {
  final List<CartItem> items;
  LoadCart(this.items);
}

// Set loading state
class SetCartLoading {
  final bool isLoading;
  SetCartLoading(this.isLoading);
}

// Set error state
class SetCartError {
  final String? error;
  SetCartError(this.error);
}
