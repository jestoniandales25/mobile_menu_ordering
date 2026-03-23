import 'package:flutter/material.dart';
import 'package:mobile_menu_ordering/blocs/cart_bloc.dart';
import 'package:mobile_menu_ordering/core/constant/app_colors.dart';
import 'package:mobile_menu_ordering/data/models/food_model.dart';
import 'package:mobile_menu_ordering/main.dart';
import 'package:provider/provider.dart';


class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final food = ModalRoute.of(context)!.settings.arguments as FoodModel;
    final isDark = context.watch<ThemeBloc>().isDark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          // ── Food Image Header ──────────────────────
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  food.img,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.lightCard,
                    child: const Center(
                      child: Text('🍽️', style: TextStyle(fontSize: 80)),
                    ),
                  ),
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        bg.withOpacity(0.8),
                        bg,
                      ],
                      stops: const [0.4, 0.8, 1.0],
                    ),
                  ),
                ),
              ),
              // Back button
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Food Info ─────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          food.name,
                          style: TextStyle(
                            color: isDark ? Colors.white : AppColors.textDark,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        food.formattedPrice,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rate + country
                  Row(
                    children: [
                      if (food.rate != null) ...[
                        const Icon(Icons.star_rounded,
                            color: AppColors.star, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          food.formattedRate,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (food.country != null) ...[
                        const Icon(Icons.location_on_rounded,
                            color: AppColors.textMuted, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          food.country!,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  if (food.description != null) ...[
                    Text(
                      'Description',
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      food.description!,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Add to Cart Bottom Bar ─────────────────────
      bottomNavigationBar: Consumer<CartBloc>(
        builder: (_, cart, __) {
          final qty = cart.quantityOf(food.id);
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            decoration: BoxDecoration(
              color: surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Quantity control
                if (qty > 0) ...[
                  Row(
                    children: [
                      _QtyButton(
                        icon: Icons.remove_rounded,
                        onTap: () => cart.removeItem(food.id),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          qty.toString(),
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                : AppColors.textDark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _QtyButton(
                        icon: Icons.add_rounded,
                        onTap: () => cart.addItem(food),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                ],

                // Add to cart button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => cart.addItem(food),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      qty > 0 ? 'Add More · ${cart.formattedTotal}' : 'Add to Cart',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}