import 'package:ecommerce_demo/core/ui/ui_padding.dart';
import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/constants/app_colors.dart';

class CartIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? iconColor;
  final double iconSize;

  const CartIcon({
    super.key,
    this.onPressed,
    this.iconColor,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) => store.state.cartState.itemCount,
      builder: (context, cartItemCount) {
        return Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: iconColor, size: iconSize),
              onPressed: onPressed,
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                    ),
                    child: child,
                  ),
                  child: Container(
                    key: ValueKey<int>(cartItemCount),
                    padding:  EdgeInsets.all(UISpacing.padding_2),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(UIRadius.radius_10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '${cartItemCount > 99 ? "99+" : cartItemCount}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
