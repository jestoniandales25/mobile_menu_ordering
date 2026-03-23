import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_model.freezed.dart';
part 'food_model.g.dart';

@freezed
 abstract class FoodModel with _$FoodModel {
  const factory FoodModel({
    @JsonKey(name: 'id') required String id,      // ✅ String not int
    @JsonKey(name: 'img') required String img,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'dsc') String? description,
    @JsonKey(name: 'price', fromJson: _parseDouble)
    @Default(0.0) double price,                   // ✅ nullable safe
    @JsonKey(name: 'rate', fromJson: _parseDoubleNullable)
    double? rate,                                 // ✅ nullable
    @JsonKey(name: 'country') String? country,
  }) = _FoodModel;

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
}

// ✅ Safe parsers — handle null, int, double, String
double _parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

double? _parseDoubleNullable(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

extension FoodModelX on FoodModel {
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get formattedRate => rate != null ? rate!.toStringAsFixed(1) : 'N/A';
  int get fullStars => rate != null ? rate!.floor() : 0;
}