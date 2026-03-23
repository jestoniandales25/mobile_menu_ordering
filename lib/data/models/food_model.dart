import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_model.freezed.dart';
part 'food_model.g.dart';

@freezed
abstract class FoodModel with _$FoodModel {
  const factory FoodModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'img') required String img,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'dsc') String? description,
    @JsonKey(name: 'price') required double price,
    @JsonKey(name: 'rate') double? rate,
    @JsonKey(name: 'country') String? country,
  }) = _FoodModel;

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
}

extension FoodModelX on FoodModel {
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  String get formattedRate =>
      rate != null ? rate!.toStringAsFixed(1) : 'N/A';

  // Star display
  int get fullStars => rate != null ? rate!.floor() : 0;
}