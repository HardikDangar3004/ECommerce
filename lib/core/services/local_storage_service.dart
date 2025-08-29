import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/cart/domain/models/cart_item.dart';
import '../../features/wishlist/domain/models/wishlist_item.dart';
import '../../features/product/domain/models/product.dart';

class LocalStorageService {
  static const String _cartKey = 'cart_items_v1';
  static const String _wishlistKey = 'wishlist_items_v1';

  LocalStorageService();

  Future<void> saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = items.map(_encodeCartItem).toList();
    await prefs.setString(_cartKey, jsonEncode(encoded));
  }

  Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cartKey);
    if (data == null || data.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(data) as List<dynamic>;
      return decoded
          .map((e) => _decodeCartItem(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveWishlistItems(List<WishlistItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = items.map(_encodeWishlistItem).toList();
    await prefs.setString(_wishlistKey, jsonEncode(encoded));
  }

  Future<List<WishlistItem>> loadWishlistItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_wishlistKey);
    if (data == null || data.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(data) as List<dynamic>;
      return decoded
          .map((e) => _decodeWishlistItem(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Encoding helpers
  Map<String, dynamic> _encodeCartItem(CartItem item) => {
    'product': item.product.toJson(),
    'quantity': item.quantity,
    'addedAt': item.addedAt.toIso8601String(),
  };

  CartItem _decodeCartItem(Map<String, dynamic> map) => CartItem(
    product: Product.fromJson(map['product'] as Map<String, dynamic>),
    quantity: (map['quantity'] as num?)?.toInt() ?? 1,
    addedAt:
        DateTime.tryParse(map['addedAt'] as String? ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> _encodeWishlistItem(WishlistItem item) => {
    'product': item.product.toJson(),
    'addedAt': item.addedAt.toIso8601String(),
  };

  WishlistItem _decodeWishlistItem(Map<String, dynamic> map) => WishlistItem(
    product: Product.fromJson(map['product'] as Map<String, dynamic>),
    addedAt:
        DateTime.tryParse(map['addedAt'] as String? ?? '') ?? DateTime.now(),
  );
}
