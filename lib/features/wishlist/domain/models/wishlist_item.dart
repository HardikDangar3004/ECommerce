import '../../../product/domain/models/product.dart';

class WishlistItem {
  final Product product;
  final DateTime addedAt;

  WishlistItem({required this.product, required this.addedAt});

  WishlistItem copyWith({Product? product, DateTime? addedAt}) {
    return WishlistItem(
      product: product ?? this.product,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WishlistItem && other.product.id == product.id;
  }

  @override
  int get hashCode => product.id.hashCode;

  @override
  String toString() =>
      'WishlistItem(product: ${product.title}, addedAt: $addedAt)';
}
