import '../domain/models/wishlist_item.dart';

class WishlistState {
  final List<WishlistItem> items;
  final bool isLoading;
  final String? error;

  const WishlistState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  WishlistState copyWith({
    List<WishlistItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return WishlistState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool containsProduct(int productId) {
    return items.any((item) => item.product.id == productId);
  }

  WishlistItem? getWishlistItem(int productId) {
    try {
      return items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  int get itemCount => items.length;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WishlistState &&
        other.items == items &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => items.hashCode ^ isLoading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      'WishlistState(items: ${items.length}, isLoading: $isLoading, error: $error)';
}
