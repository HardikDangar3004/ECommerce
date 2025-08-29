import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:ecommerce_demo/core/ui/ui_space.dart';
import 'package:flutter/material.dart';
import '../../domain/models/product.dart';
import '../../data/services/product_service.dart';
import '../widgets/product_card.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../auth/store/auth_actions.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/product_skeleton.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../wishlist/store/wishlist_actions.dart';
import '../../../cart/store/cart_actions.dart';
import '../../../cart/presentation/widgets/cart_icon.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/ui/ui_padding.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductService _productService = ProductService();
  final ScrollController _scrollController = ScrollController();

  List<Product> _products = [];
  List<String> _categories = [];
  String? _selectedCategory;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasReachedMax = false;
  bool _hasError = false;
  String? _errorMessage;
  int _currentSkip = 0;
  static const int _limit = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreProducts();
    }
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = null;
      _products.clear();
      _currentSkip = 0;
      _hasReachedMax = false;
    });

    try {
      await Future.wait([_loadCategories(), _loadProducts()]);
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _productService.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      debugPrint('Failed to load categories: $e');
    }
  }

  Future<void> _loadProducts() async {
    try {
      final response = await _productService.getProducts(
        skip: _currentSkip,
        limit: _limit,
        category: _selectedCategory,
        search: null,
      );

      setState(() {
        if (_currentSkip == 0) {
          _products = response.products ?? [];
        } else {
          _products.addAll(response.products ?? []);
        }
        _hasReachedMax = (response.products?.length ?? 0) < _limit;
      });
    } catch (e) {
      if (mounted) {
        SnackbarUtils.showError(
          context,
          message: 'Failed to load products: $e',
        );
      }
    }
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoadingMore || _hasReachedMax) return;

    setState(() {
      _isLoadingMore = true;
    });

    _currentSkip += _limit;
    await _loadProducts();

    setState(() {
      _isLoadingMore = false;
    });
  }

  Future<void> _refreshProducts() async {
    _currentSkip = 0;
    _hasReachedMax = false;
    await _loadProducts();
  }



  void _onAddToCart(Product product) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(AddToCart(product));

    SnackbarUtils.showSuccess(
      context,
      message: '${product.title} added to cart!',
    );
  }

  void _onToggleFavorite(Product product) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(ToggleWishlist(product));

    final isInWishlist = store.state.wishlistState.containsProduct(product.id!);
    final message = isInWishlist
        ? '${product.title} added to wishlist!'
        : '${product.title} removed from wishlist!';

    SnackbarUtils.showSuccess(context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.products),
        actions: [
          CartIcon(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/wishlist');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final store = StoreProvider.of<AppState>(context, listen: false);
              store.dispatch(LogoutRequested());
            },
          ),
        ],
      ),
      body: Column(
        children: [

          // Products Grid
          Expanded(child: _buildProductsGrid()),
        ],
      ),
    );
  }



  Widget _buildProductsGrid() {
    if (_isLoading && _products.isEmpty) {
      return _buildSkeletonGrid();
    }

    if (_hasError && _products.isEmpty) {
      return CustomErrorWidget(
        message: _errorMessage ?? 'Failed to load products',
        onRetry: _loadInitialData,
        icon: Icons.inventory_2_outlined,
      );
    }

    if (_products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: AppColors.gray400,
            ),
            sizedBoxH16,
            Text(
              'No ${AppStrings.products.toLowerCase()} found',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
            ),
            sizedBoxH8,
            Text(
              AppStrings.tryAdjustYourFilters,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textHint),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshProducts,
            child: GridView.builder(
              controller: _scrollController,
              padding: UISpacing.all(UISpacing.padding_16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(),
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                  },
                  onAddToCart: () => _onAddToCart(product),
                  onToggleFavorite: () => _onToggleFavorite(product),
                  isInCart: false, // This will be handled by Redux state
                  isFavorite: false, // This will be handled by Redux state
                );
              },
            ),
          ),
        ),

        // Load More Button
        if (!_hasReachedMax && _products.isNotEmpty)
          Padding(
            padding: UISpacing.all(UISpacing.padding_16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoadingMore ? null : _loadMoreProducts,
                style: ElevatedButton.styleFrom(
                  padding:  EdgeInsets.symmetric(vertical: UISpacing.padding_16 ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UIRadius.radius_12),
                  ),
                ),
                child: _isLoadingMore
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(AppStrings.loadMore),
              ),
            ),
          ),
      ],
    );
  }

  int _getCrossAxisCount() {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 2; // Mobile
    } else if (width < 900) {
      return 3; // Tablet
    } else {
      return 4; // Desktop
    }
  }

  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding:  EdgeInsets.all(UISpacing.padding_16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(),
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6, // Show 6 skeleton items
      itemBuilder: (context, index) => const ProductSkeleton(),
    );
  }
}
