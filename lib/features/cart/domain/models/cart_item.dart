import '../../../product/domain/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final DateTime addedAt;

  const CartItem({
    required this.product,
    required this.quantity,
    required this.addedAt,
  });

  CartItem copyWith({Product? product, int? quantity, DateTime? addedAt}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  double get totalPrice => (product.price ?? 0) * quantity;
  String get displayTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.product.id == product.id;
  }

  @override
  int get hashCode => product.id.hashCode;

  @override
  String toString() =>
      'CartItem(product: ${product.title}, quantity: $quantity)';
}
