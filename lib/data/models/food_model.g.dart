// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FoodModel _$FoodModelFromJson(Map<String, dynamic> json) => _FoodModel(
  id: json['id'] as String,
  img: json['img'] as String,
  name: json['name'] as String,
  description: json['dsc'] as String?,
  price: json['price'] == null ? 0.0 : _parseDouble(json['price']),
  rate: _parseDoubleNullable(json['rate']),
  country: json['country'] as String?,
);

Map<String, dynamic> _$FoodModelToJson(_FoodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'name': instance.name,
      'dsc': instance.description,
      'price': instance.price,
      'rate': instance.rate,
      'country': instance.country,
    };
