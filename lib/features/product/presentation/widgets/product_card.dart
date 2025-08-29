import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:ecommerce_demo/core/ui/ui_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../domain/models/product.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/ui/ui_padding.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onToggleFavorite;
  final bool isInCart;
  final bool isFavorite;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onToggleFavorite,
    this.isInCart = false,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store, product.id!),
      builder: (context, viewModel) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIRadius.radius_12),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(UIRadius.radius_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                _buildImageSection(context, viewModel.isInWishlist),

                // Product Info
                Expanded(
                  child: Padding(
                    padding: UISpacing.all(UISpacing.padding_12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        _buildTitle(),
                        sizedBoxH4,

                        // Brand
                        if (product.brand != null) _buildBrand(context),

                        // Rating
                        _buildRating(context),
                        sizedBoxH8,

                        // Price Section
                        _buildPriceSection(context),
                        sizedBoxH8,

                        // Action Buttons
                        _buildActionButtons(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSection(BuildContext context, bool isInWishlist) {
    return Stack(
      children: [
        // Product Image
        CachedImageWidget(
          imageUrl: product.primaryImage,
          height: 160,
          width: double.infinity,
          borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(UIRadius.radius_12),
            topRight: Radius.circular(UIRadius.radius_12),
          ),
        ),

        // Favorite Button
        if (onToggleFavorite != null)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWishlist
                      ? Theme.of(context).colorScheme.error
                      : AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: onToggleFavorite,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ),
          ),

        // Discount Badge
        if (product.hasDiscount)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: UISpacing.padding_8, vertical: UISpacing.padding_4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(UIRadius.radius_12),
              ),
              child: Text(
                '-${product.discountPercentage!.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      product.title ?? AppStrings.productTitle,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBrand(BuildContext context) {
    return Text(
      product.brand!,
      style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRating(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        sizedBoxW4,
        Text(
          product.displayRating,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        sizedBoxW4,
        Text(
          '(${product.reviews?.length ?? 0})',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.hasDiscount) ...[
          Text(
            product.displayPrice,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textHint,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          sizedBoxH2,
        ],
        Text(
          product.displayDiscountPrice,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: product.hasDiscount
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Add to Cart Button
        if (onAddToCart != null) ...[
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onAddToCart,
              icon: Icon(
                isInCart ? Icons.check : Icons.shopping_cart,
                size: 16,
              ),
              label: Text(
                isInCart ? AppStrings.addedToCart : AppStrings.addToCart,
                style: const TextStyle(fontSize: 12),
              ),
              style: ElevatedButton.styleFrom(
                padding: UISpacing.symmetric(vertical: UISpacing.padding_8),
                backgroundColor: isInCart
                    ? Theme.of(context).colorScheme.primary
                    : null,
                foregroundColor: isInCart
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
            ),
          ),
        ] else ...[
          const Spacer(),
        ],
      ],
    );
  }
}

class _ViewModel {
  final bool isInWishlist;
  final bool isInCart;
  final int cartQuantity;

  _ViewModel({
    required this.isInWishlist,
    required this.isInCart,
    required this.cartQuantity,
  });

  static _ViewModel fromStore(Store<AppState> store, int productId) {
    return _ViewModel(
      isInWishlist: store.state.wishlistState.containsProduct(productId),
      isInCart: store.state.cartState.containsProduct(productId),
      cartQuantity: store.state.cartState.getItemQuantity(productId),
    );
  }
}
