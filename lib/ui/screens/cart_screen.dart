import 'package:flutter/material.dart';
import 'package:mobile_menu_ordering/blocs/cart_bloc.dart';
import 'package:mobile_menu_ordering/core/constant/app_colors.dart';
import 'package:mobile_menu_ordering/data/models/cart_item_model.dart';
import 'package:mobile_menu_ordering/data/models/food_model.dart';
import 'package:mobile_menu_ordering/main.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
            // ── Header ──────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(8, 12, 20, 12),
              color: surface,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Your Cart',
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.textDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // Clear cart
                  Consumer<CartBloc>(
                    builder: (_, cart, __) => cart.items.isEmpty
                        ? const SizedBox.shrink()
                        : TextButton(
                            onPressed: () => _showClearDialog(context, cart),
                            child: const Text(
                              'Clear',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            // ── Cart Items ───────────────────────────
            Expanded(
              child: Consumer<CartBloc>(
                builder: (context, cart, _) {
                  if (cart.items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '🛒',
                            style: TextStyle(fontSize: 64),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(
                              color: isDark ? Colors.white : AppColors.textDark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Add some delicious food!',
                            style: TextStyle(color: AppColors.textMuted),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Browse Food'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (_, index) => _CartItemCard(
                      item: cart.items[index],
                      isDark: isDark,
                      surface: surface,
                    ),
                  );
                },
              ),
            ),

            // ── Checkout Bar ─────────────────────────
            Consumer<CartBloc>(
              builder: (_, cart, __) => cart.items.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
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
                      child: Column(
                        children: [
                          // Summary
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${cart.totalItems} items',
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                cart.formattedTotal,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : AppColors.textDark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Checkout button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  _showCheckoutDialog(context, cart),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                'Checkout · ${cart.formattedTotal}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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

  void _showClearDialog(BuildContext context, CartBloc cart) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Remove all items from cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              cart.clearCart();
              Navigator.pop(context);
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CartBloc cart) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('🎉 Order Placed!'),
        content: Text(
          'Your order of ${cart.formattedTotal} has been placed successfully!',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              cart.clearCart();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

// ── Cart Item Card ──────────────────────────────────
class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final bool isDark;
  final Color surface;

  const _CartItemCard({
    required this.item,
    required this.isDark,
    required this.surface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.food.img,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 70,
                height: 70,
                color: AppColors.lightCard,
                child: const Center(
                  child: Text('🍽️', style: TextStyle(fontSize: 28)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.food.formattedPrice,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Total price
              Text(
                item.formattedTotal,
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Consumer<CartBloc>(
                    builder: (_, cart, __) => Row(
                      children: [
                        _QtyBtn(
                          icon: item.quantity == 1
                              ? Icons.delete_outline_rounded
                              : Icons.remove_rounded,
                          color: item.quantity == 1
                              ? Colors.redAccent
                              : AppColors.primary,
                          onTap: () => cart.removeItem(item.food.id),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            item.quantity.toString(),
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : AppColors.textDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        _QtyBtn(
                          icon: Icons.add_rounded,
                          color: AppColors.primary,
                          onTap: () => cart.addItem(item.food),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QtyBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 16),
      ),
    );
  }
}