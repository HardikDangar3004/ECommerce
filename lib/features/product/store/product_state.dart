import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      brand: json['brand'] as String,
      category: json['category'] as String,
      thumbnail: json['thumbnail'] as String,
      images: List<String>.from(json['images'] as List),
    );
  }

  double get discountedPrice => price * (1 - discountPercentage / 100);

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    discountPercentage,
    rating,
    stock,
    brand,
    category,
    thumbnail,
    images,
  ];
}

class ProductState extends Equatable {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final bool hasReachedMax;
  final int currentPage;
  final String? selectedCategory;

  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.selectedCategory,
  });

  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
    int? currentPage,
    String? selectedCategory,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  factory ProductState.initial() => const ProductState();

  @override
  List<Object?> get props => [
    products,
    isLoading,
    error,
    hasReachedMax,
    currentPage,
    selectedCategory,
  ];
}
