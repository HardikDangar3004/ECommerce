import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../../store/cart_state.dart';
import '../../store/cart_actions.dart';
import '../../domain/models/cart_item.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/di/service_locator.dart';
import '../widgets/cart_item_tile.dart';
import '../../../../core/ui/ui_space.dart';
import '../../../../core/ui/ui_padding.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.shoppingCart),
        actions: [
          StoreConnector<AppState, CartState>(
            converter: (store) => store.state.cartState,
            builder: (context, cartState) {
              if (cartState.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.clear_all),
                  onPressed: () => _showClearCartDialog(context),
                  tooltip: 'Clear Cart',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: StoreConnector<AppState, CartState>(
        converter: (store) => store.state.cartState,
        builder: (context, cartState) {
          if (cartState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartState.error != null) {
            return CustomErrorWidget(message: cartState.error!, onRetry: () {});
          }

          if (cartState.isEmpty) {
            return _buildEmptyCart(context);
          }

          return _buildCartContent(context, cartState);
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: AppColors.gray400,
          ),
          sizedBoxH16,
          Text(
            AppStrings.yourCartEmpty,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          sizedBoxH8,
          Text(
            AppStrings.continueShopping,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.textHint),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartState cartState) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    if (isWide) {
      // Two-pane layout for tablets/desktops
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildCartItems(context, cartState)),
          SizedBox(width: 360, child: _buildCartSummary(context, cartState)),
        ],
      );
    }

    // Column layout for mobile
    return Column(
      children: [
        Expanded(child: _buildCartItems(context, cartState)),
        _buildCartSummary(context, cartState),
      ],
    );
  }

  Widget _buildCartItems(BuildContext context, CartState cartState) {
    return RefreshIndicator(
      onRefresh: () async {
        final items = await ServiceLocator.localStorageService.loadCartItems();
        final store = StoreProvider.of<AppState>(context, listen: false);
        store.dispatch(LoadCart(items));
      },
      child: ListView.builder(
        padding: UISpacing.all(UISpacing.padding_16),
        itemCount: cartState.items.length,
        itemBuilder: (context, index) {
          final cartItem = cartState.items[index];
          return CartItemTile(
            cartItem: cartItem,
            onDecrease: () => _decreaseQuantity(context, cartItem),
            onIncrease: () => _increaseQuantity(context, cartItem),
            onRemove: () => _removeFromCart(context, cartItem),
          );
        },
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartState cartState) {
    return Container(
      padding: UISpacing.all(UISpacing.padding_20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: UIRadius.radius_10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.orderSummary,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UISpacing.padding_12,
                  vertical: UISpacing.padding_6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(UIRadius.radius_20),
                ),
                child: Text(
                  '${cartState.itemCount} ${AppStrings.items}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          sizedBoxH16,

          // Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '${AppStrings.total}:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                cartState.displayTotalAmount,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          sizedBoxH24,

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _proceedToCheckout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UIRadius.radius_12),
                ),
                elevation: 2,
              ),
              child: const Text(
                AppStrings.proceedToCheckout,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _increaseQuantity(BuildContext context, CartItem cartItem) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(
      UpdateCartItemQuantity(cartItem.product.id!, cartItem.quantity + 1),
    );

    SnackbarUtils.showSuccess(context, message: AppStrings.quantityUpdated);
  }

  void _decreaseQuantity(BuildContext context, CartItem cartItem) {
    if (cartItem.quantity <= 1) return;

    final store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(
      UpdateCartItemQuantity(cartItem.product.id!, cartItem.quantity - 1),
    );

    SnackbarUtils.showSuccess(context, message: AppStrings.quantityUpdated);
  }

  void _removeFromCart(BuildContext context, CartItem cartItem) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(RemoveFromCart(cartItem.product.id!));

    SnackbarUtils.showSuccess(
      context,
      message: '${cartItem.product.title} ${AppStrings.removedFromCart}',
    );
  }

  // _moveToWishlist handled inside CartItemTile

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear ${AppStrings.cart}'),
          content: const Text(AppStrings.clearCartConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () {
                final store = StoreProvider.of<AppState>(
                  context,
                  listen: false,
                );
                store.dispatch(ClearCart());
                Navigator.of(context).pop();

                SnackbarUtils.showSuccess(
                  context,
                  message: AppStrings.cartCleared,
                );
              },
              child: Text(
                AppStrings.clearAll,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _proceedToCheckout(BuildContext context) {
    // TODO: Implement checkout functionality
    SnackbarUtils.showInfo(context, message: AppStrings.checkoutComingSoon);
  }
}
