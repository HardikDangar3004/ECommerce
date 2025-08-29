import 'package:ecommerce_demo/core/ui/ui_padding.dart';
import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:ecommerce_demo/core/ui/ui_space.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIRadius.radius_12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(UIRadius.radius_12),
            ),
            child: Icon(Icons.image, size: 48, color: AppColors.textHint),
          ),

          // Content skeleton
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(UISpacing.padding_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title skeleton
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(UIRadius.radius_4),
                    ),
                  ),
                  sizedBoxH8,

                  // Brand skeleton
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(UIRadius.radius_4),
                    ),
                  ),
                  sizedBoxH8,

                  // Rating skeleton
                  Row(
                    children: [
                      Container(
                        height: 12,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.borderLight,
                          borderRadius: BorderRadius.circular(UIRadius.radius_4),
                        ),
                      ),
                      sizedBoxW8,
                      Container(
                        height: 12,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.borderLight,
                          borderRadius: BorderRadius.circular(UIRadius.radius_4),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxH8,

                  // Price skeleton
                  Container(
                    height: 16,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(UIRadius.radius_4),
                    ),
                  ),
                  sizedBoxH8,

                  // Button skeleton
                  Container(
                    height: 36,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(UIRadius.radius_8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
