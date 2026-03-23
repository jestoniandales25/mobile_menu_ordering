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

  bool isInCart(int foodId) =>
      _items.any((item) => item.food.id == foodId);

  int quantityOf(int foodId) {
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

  // Remove one quantity — removes item if quantity reaches 0
  void removeItem(int foodId) {
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

  // Remove entire item regardless of quantity
  void removeItemCompletely(int foodId) {
    _items.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  // Clear entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}