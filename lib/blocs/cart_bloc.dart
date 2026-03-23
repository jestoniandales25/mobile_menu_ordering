import 'package:flutter/foundation.dart';
import 'package:mobile_menu_ordering/data/models/cart_item_model.dart';
import 'package:mobile_menu_ordering/data/models/food_model.dart';


class CartBloc extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  // Getters
  List<CartItemModel> get items => List.unmodifiable(_items);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  String get formattedTotal => '\$${totalPrice.toStringAsFixed(2)}';

  // ✅ String id — matches food_model.dart
  bool isInCart(String foodId) =>
      _items.any((item) => item.food.id == foodId);

  // ✅ String id
  int quantityOf(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    return index != -1 ? _items[index].quantity : 0;
  }

  // Add item — increments if already in cart
  void addItem(FoodModel food) {
    final index = _items.indexWhere((item) => item.food.id == food.id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(CartItemModel(food: food));
    }
    notifyListeners();
  }

  // ✅ String id — remove one quantity
  void removeItem(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index] = _items[index].copyWith(
          quantity: _items[index].quantity - 1,
        );
      } else {
        _items.removeAt(index);
      }
    }
    notifyListeners();
  }

  // ✅ String id — remove entire item
  void removeItemCompletely(String foodId) {
    _items.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  // Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}