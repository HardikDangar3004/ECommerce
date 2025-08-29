import 'package:redux/redux.dart';
import 'app_state.dart';
import '../../features/auth/store/auth_reducer.dart';
import '../../features/product/store/product_reducer.dart';
import '../../features/cart/store/cart_reducer.dart';
import '../../features/wishlist/store/wishlist_reducer.dart';
import 'app_actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    isDarkMode: _isDarkModeReducer(state.isDarkMode, action),
    authState: authReducer(state.authState, action),
    productState: productReducer(state.productState, action),
    cartState: cartReducer(state.cartState, action),
    wishlistState: wishlistReducer(state.wishlistState, action),
  );
}

bool _isDarkModeReducer(bool current, dynamic action) {
  if (action is SetDarkMode) {
    return action.isDarkMode;
  }
  if (action is ToggleDarkMode) {
    return !current;
  }
  return current;
}
