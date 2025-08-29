import 'package:equatable/equatable.dart';
import 'product_state.dart';

abstract class ProductAction extends Equatable {
  const ProductAction();

  @override
  List<Object?> get props => [];
}

class FetchProductsRequested extends ProductAction {
  final int page;
  final String? category;
  final bool refresh;

  const FetchProductsRequested({
    this.page = 1,
    this.category,
    this.refresh = false,
  });

  @override
  List<Object?> get props => [page, category, refresh];
}

class FetchProductsSuccess extends ProductAction {
  final List<Product> products;
  final int page;
  final bool hasReachedMax;

  const FetchProductsSuccess({
    required this.products,
    required this.page,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [products, page, hasReachedMax];
}

class FetchProductsFailure extends ProductAction {
  final String error;

  const FetchProductsFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class SetSelectedCategory extends ProductAction {
  final String? category;

  const SetSelectedCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class ClearProducts extends ProductAction {}
