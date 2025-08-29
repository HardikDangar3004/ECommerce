import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/store/app_state.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../product/domain/models/product.dart';
import '../../store/wishlist_actions.dart';
import '../../../../core/ui/ui_space.dart';
import '../../../../core/ui/ui_padding.dart';

class WishlistItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onRemove;

  const WishlistItemCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product-detail',
            arguments: {'product': product},
          );
        },
        borderRadius: BorderRadius.circular(UIRadius.radius_12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(UIRadius.radius_12),
                    topRight: Radius.circular(UIRadius.radius_12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(UIRadius.radius_12),
                    topRight: Radius.circular(UIRadius.radius_12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: Icon(
                        Icons.image,
                        size: 48,
                        color: AppColors.gray400,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error,
                        size: 48,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Product Info
            Padding(
              padding: UISpacing.all(UISpacing.padding_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    product.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  sizedBoxH4,
                  // Product Brand
                  Text(
                    product.brand ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.gray600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  sizedBoxH8,
                  // Price
                  if (product.discountPercentage! > 0) ...[
                    Text(
                      '\$${product.price!.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.gray500,
                      ),
                    ),
                    Text(
                      product.displayDiscountPrice,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ] else ...[
                    Text(
                      '\$${product.price!.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  sizedBoxH12,
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onAddToCart,
                          style: ElevatedButton.styleFrom(
                            padding:  EdgeInsets.symmetric(vertical: UISpacing.padding_8),
                          ),
                          child: const Text(
                            AppStrings.addToCart,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      sizedBoxW8,
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(
                          Icons.favorite,
                          color: AppColors.error,
                          size: 20,
                        ),
                        tooltip: AppStrings.removeFromWishlist,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
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
}
