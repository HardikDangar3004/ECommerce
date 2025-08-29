import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../../store/wishlist_state.dart';
import '../../store/wishlist_actions.dart';
import '../../../product/presentation/widgets/product_card.dart';
import '../../../cart/store/cart_actions.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/ui/ui_space.dart';
import '../../../../core/ui/ui_padding.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ${AppStrings.wishlist}'),
        actions: [
          StoreConnector<AppState, WishlistState>(
            converter: (store) => store.state.wishlistState,
            builder: (context, wishlistState) {
              if (wishlistState.items.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.clear_all),
                  onPressed: () => _showClearWishlistDialog(context),
                  tooltip: AppStrings.clearWishlist,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: StoreConnector<AppState, WishlistState>(
        converter: (store) => store.state.wishlistState,
        builder: (context, wishlistState) {
          if (wishlistState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wishlistState.error != null) {
            return CustomErrorWidget(
              message: wishlistState.error!,
              onRetry: () {
              },
            );
          }

          if (wishlistState.items.isEmpty) {
            return _buildEmptyWishlist(context);
          }

          return _buildWishlistGrid(context, wishlistState);
        },
      ),
    );
  }

  Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: AppColors.gray400),
          sizedBoxH16,
          Text(
            AppStrings.wishlistEmpty,
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

  Widget _buildWishlistGrid(BuildContext context, WishlistState wishlistState) {
    return RefreshIndicator(
      onRefresh: () async {
      },
      child: GridView.builder(
        padding: UISpacing.all(UISpacing.padding_16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context),
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: wishlistState.items.length,
        itemBuilder: (context, index) {
          final wishlistItem = wishlistState.items[index];
          final product = wishlistItem.product;

          return ProductCard(
            product: product,
            onTap: () {
            },
            onAddToCart: () => _onAddToCart(context, product),
            onToggleFavorite: () => _onToggleFavorite(context, product),
            isInCart: false,
            isFavorite: true,
          );
        },
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 2; // Mobile
    } else if (width < 900) {
      return 3; // Tablet
    } else {
      return 4; // Desktop
    }
  }

  void _onAddToCart(BuildContext context, product) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(AddToCart(product));

    SnackbarUtils.showSuccess(
      context,
      message: '${product.title} added to cart!',
    );
  }

  void _onToggleFavorite(BuildContext context, product) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(ToggleWishlist(product));

    SnackbarUtils.showSuccess(
      context,
      message: '${product.title} removed from wishlist!',
    );
  }

  void _showClearWishlistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear ${AppStrings.wishlist}'),
          content: const Text(AppStrings.clearWishlistConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () {
                final store = StoreProvider.of<AppState>(
                  context,
                  listen: false,
                );
                store.dispatch(ClearWishlist());
                Navigator.of(context).pop();

                SnackbarUtils.showSuccess(
                  context,
                  message: AppStrings.wishlistCleared,
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
}
