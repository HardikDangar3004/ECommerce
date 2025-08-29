import '../domain/models/cart_item.dart';

class CartState {
  final List<CartItem> items;
  final bool isLoading;
  final String? error;

  const CartState({this.items = const [], this.isLoading = false, this.error});

  CartState copyWith({List<CartItem>? items, bool? isLoading, String? error}) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool containsProduct(int productId) {
    return items.any((item) => item.product.id == productId);
  }

  CartItem? getCartItem(int productId) {
    try {
      return items.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }

  int getItemQuantity(int productId) {
    final item = getCartItem(productId);
    return item?.quantity ?? 0;
  }

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);
  String get displayTotalAmount => '\$${totalAmount.toStringAsFixed(2)}';

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartState &&
        other.items == items &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => items.hashCode ^ isLoading.hashCode ^ error.hashCode;

  @override
  String toString() =>
      'CartState(items: ${items.length}, total: $displayTotalAmount, isLoading: $isLoading, error: $error)';
}
