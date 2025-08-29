import 'package:redux/redux.dart';
import 'product_actions.dart';
import 'product_state.dart';

ProductState productReducer(ProductState state, dynamic action) {
  if (action is FetchProductsRequested) {
    if (action.refresh) {
      return state.copyWith(
        isLoading: true,
        error: null,
        products: [],
        currentPage: 1,
        hasReachedMax: false,
      );
    } else {
      return state.copyWith(isLoading: true, error: null);
    }
  } else if (action is FetchProductsSuccess) {
    if (action.page == 1) {
      return state.copyWith(
        products: action.products,
        isLoading: false,
        error: null,
        currentPage: action.page,
        hasReachedMax: action.hasReachedMax,
      );
    } else {
      return state.copyWith(
        products: [...state.products, ...action.products],
        isLoading: false,
        error: null,
        currentPage: action.page,
        hasReachedMax: action.hasReachedMax,
      );
    }
  } else if (action is FetchProductsFailure) {
    return state.copyWith(isLoading: false, error: action.error);
  } else if (action is SetSelectedCategory) {
    return state.copyWith(
      selectedCategory: action.category,
      products: [],
      currentPage: 1,
      hasReachedMax: false,
    );
  } else if (action is ClearProducts) {
    return state.copyWith(products: [], currentPage: 1, hasReachedMax: false);
  }
  return state;
}
