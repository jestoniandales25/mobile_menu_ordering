import 'package:flutter/material.dart';
import 'package:mobile_menu_ordering/blocs/cart_bloc.dart';
import 'package:mobile_menu_ordering/blocs/food_bloc.dart';
import 'package:mobile_menu_ordering/core/constants/api_constants.dart';
import 'package:mobile_menu_ordering/core/constants/app_colors.dart';
import 'package:mobile_menu_ordering/data/models/food_model.dart';
import 'package:mobile_menu_ordering/main.dart';
import 'package:provider/provider.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().isDark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, isDark, surface),
            _buildSearchBar(context, isDark, surface),
            _buildCategoryFilter(context, isDark),
            Expanded(child: _buildFoodGrid(context, isDark, surface)),
          ],
        ),
      ),

      // ── Floating Cart Button ──────────────────────
      floatingActionButton: Consumer<CartBloc>(
        builder: (_, cart, __) => cart.totalItems == 0
            ? const SizedBox.shrink()
            : FloatingActionButton.extended(
                onPressed: () => Navigator.pushNamed(context, '/cart'),
                backgroundColor: AppColors.primary,
                icon: const Icon(Icons.shopping_cart_rounded,
                    color: Colors.white),
                label: Text(
                  '${cart.totalItems} items · ${cart.formattedTotal}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────
  Widget _buildHeader(BuildContext context, bool isDark, Color surface) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      color: surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FoodOrder 🍔',
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.textDark,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'What are you craving?',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Theme toggle
              Consumer<ThemeBloc>(
                builder: (_, themeBloc, __) => IconButton(
                  onPressed: themeBloc.toggle,
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
              // Cart icon with badge
              Consumer<CartBloc>(
                builder: (_, cart, __) => Stack(
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/cart'),
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    if (cart.totalItems > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              cart.totalItems.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Search Bar ───────────────────────────────────
  Widget _buildSearchBar(BuildContext context, bool isDark, Color surface) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        onChanged: context.read<FoodBloc>().search,
        style: TextStyle(
          color: isDark ? Colors.white : AppColors.textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Search food, country...',
          hintStyle: const TextStyle(color: AppColors.textMuted),
          prefixIcon:
              const Icon(Icons.search, color: AppColors.textMuted),
          filled: true,
          fillColor: surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // ── Category Filter ──────────────────────────────
  Widget _buildCategoryFilter(BuildContext context, bool isDark) {
    return Consumer<FoodBloc>(
      builder: (_, bloc, __) => SizedBox(
        height: 44,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: ApiConstants.categories.length,
          itemBuilder: (_, index) {
            final category = ApiConstants.categories[index];
            final label = ApiConstants.categoryLabels[category] ?? category;
            final isSelected = bloc.selectedCategory == category;

            return GestureDetector(
              onTap: () => context.read<FoodBloc>().loadFoods(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.transparent,
                  ),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : isDark
                            ? Colors.white70
                            : AppColors.textMuted,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Food Grid ────────────────────────────────────
  Widget _buildFoodGrid(BuildContext context, bool isDark, Color surface) {
    return Consumer<FoodBloc>(
      builder: (context, bloc, _) {
        if (bloc.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (bloc.state == FoodState.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    color: Colors.redAccent, size: 48),
                const SizedBox(height: 12),
                Text(
                  bloc.error ?? 'Something went wrong',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: bloc.retry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }

        if (bloc.foods.isEmpty) {
          return const Center(
            child: Text(
              'No food found 🍽️',
              style: TextStyle(color: AppColors.textMuted),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: bloc.foods.length,
          itemBuilder: (_, index) => _FoodCard(
            food: bloc.foods[index],
            isDark: isDark,
            surface: surface,
          ),
        );
      },
    );
  }
}

// ── Food Card ───────────────────────────────────────
class _FoodCard extends StatelessWidget {
  final FoodModel food;
  final bool isDark;
  final Color surface;

  const _FoodCard({
    required this.food,
    required this.isDark,
    required this.surface,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/detail',
        arguments: food,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Food Image ──────────────────────────
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16)),
                    child: Image.network(
                      food.img,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.lightCard,
                        child: const Center(
                          child: Text('🍽️',
                              style: TextStyle(fontSize: 40)),
                        ),
                      ),
                    ),
                  ),
                  // Rate badge
                  if (food.rate != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded,
                                color: AppColors.star, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              food.formattedRate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ── Food Info ───────────────────────────
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          food.formattedPrice,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Add to cart
                        Consumer<CartBloc>(
                          builder: (_, cart, __) {
                            final inCart = cart.isInCart(food.id);
                            return GestureDetector(
                              onTap: () => cart.addItem(food),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: inCart
                                      ? AppColors.primary
                                      : AppColors.primary.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  inCart
                                      ? Icons.check_rounded
                                      : Icons.add_rounded,
                                  color: inCart
                                      ? Colors.white
                                      : AppColors.primary,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}