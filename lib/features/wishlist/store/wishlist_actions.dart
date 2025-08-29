import '../domain/models/wishlist_item.dart';
import '../../product/domain/models/product.dart';

// Add product to wishlist
class AddToWishlist {
  final Product product;
  AddToWishlist(this.product);
}

// Remove product from wishlist
class RemoveFromWishlist {
  final int productId;
  RemoveFromWishlist(this.productId);
}

// Toggle product in wishlist (add if not present, remove if present)
class ToggleWishlist {
  final Product product;
  ToggleWishlist(this.product);
}

// Clear all wishlist items
class ClearWishlist {}

// Load wishlist from storage
class LoadWishlist {
  final List<WishlistItem> items;
  LoadWishlist(this.items);
}

// Set loading state
class SetWishlistLoading {
  final bool isLoading;
  SetWishlistLoading(this.isLoading);
}

// Set error state
class SetWishlistError {
  final String? error;
  SetWishlistError(this.error);
}
