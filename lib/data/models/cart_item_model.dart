import 'package:freezed_annotation/freezed_annotation.dart';
import 'food_model.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
abstract class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    required FoodModel food,
    @Default(1) int quantity,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}

extension CartItemModelX on CartItemModel {
  double get totalPrice => food.price * quantity;
  String get formattedTotal => '\$${totalPrice.toStringAsFixed(2)}';
}