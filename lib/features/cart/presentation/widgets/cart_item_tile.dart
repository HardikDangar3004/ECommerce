import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:ecommerce_demo/core/ui/ui_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/store/app_state.dart';
import '../../../cart/domain/models/cart_item.dart';
import '../../../cart/store/cart_actions.dart';
import '../../../wishlist/store/wishlist_actions.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/ui/ui_padding.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: UISpacing.only(bottom: UISpacing.margin_16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIRadius.radius_12)),
      child: Padding(
        padding: UISpacing.all(UISpacing.padding_16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(UIRadius.radius_8),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  cartItem.product.primaryImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.gray300,
                      child: Icon(
                        Icons.image,
                        color: AppColors.textSecondary,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
            ),
            sizedBoxW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title ?? 'Product Title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (cartItem.product.brand != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      cartItem.product.brand!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  sizedBoxH8,
                  Text(
                    cartItem.product.displayPrice,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                  sizedBoxH12,
                  Row(
                    children: [
                      _quantityButton(
                        context,
                        icon: Icons.remove,
                        onPressed: onDecrease,
                        isEnabled: cartItem.quantity > 1,
                      ),
                      Container(
                        width: 50,
                        height: 40,
                        margin:  EdgeInsets.symmetric(horizontal: UISpacing.margin_8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(UIRadius.radius_8),
                        ),
                        child: Center(
                          child: Text(
                            '${cartItem.quantity}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      _quantityButton(
                        context,
                        icon: Icons.add,
                        onPressed: onIncrease,
                        isEnabled: true,
                      ),
                      const Spacer(),
                      StoreConnector<AppState, bool>(
                        converter: (store) => store.state.wishlistState
                            .containsProduct(cartItem.product.id!),
                        builder: (context, isInWishlist) {
                          return IconButton(
                            tooltip: isInWishlist
                                ? AppStrings.inWishlist
                                : AppStrings.moveToWishlist,
                            onPressed: () => _moveToWishlist(context),
                            icon: Icon(
                              isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        tooltip: AppStrings.removeFromCart,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.primary : AppColors.gray300,
        borderRadius: BorderRadius.circular(UIRadius.radius_8),
      ),
      child: IconButton(
        onPressed: isEnabled ? onPressed : null,
        icon: Icon(
          icon,
          color: isEnabled ? AppColors.white : AppColors.textSecondary,
          size: 20,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  void _moveToWishlist(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    final productId = cartItem.product.id!;
    final alreadyInWishlist = store.state.wishlistState.containsProduct(
      productId,
    );
    if (!alreadyInWishlist) {
      store.dispatch(AddToWishlist(cartItem.product));
    }
    store.dispatch(RemoveFromCart(productId));
    SnackbarUtils.showSuccess(
      context,
      message: alreadyInWishlist
          ? '${cartItem.product.title} ${AppStrings.removedFromCart}'
          : '${cartItem.product.title} ${AppStrings.moveToWishlist}',
    );
  }
}
