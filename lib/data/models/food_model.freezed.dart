// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FoodModel {

@JsonKey(name: 'id') String get id;// ✅ String not int
@JsonKey(name: 'img') String get img;@JsonKey(name: 'name') String get name;@JsonKey(name: 'dsc') String? get description;@JsonKey(name: 'price', fromJson: _parseDouble) double get price;// ✅ nullable safe
@JsonKey(name: 'rate', fromJson: _parseDoubleNullable) double? get rate;// ✅ nullable
@JsonKey(name: 'country') String? get country;
/// Create a copy of FoodModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FoodModelCopyWith<FoodModel> get copyWith => _$FoodModelCopyWithImpl<FoodModel>(this as FoodModel, _$identity);

  /// Serializes this FoodModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FoodModel&&(identical(other.id, id) || other.id == id)&&(identical(other.img, img) || other.img == img)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,img,name,description,price,rate,country);

@override
String toString() {
  return 'FoodModel(id: $id, img: $img, name: $name, description: $description, price: $price, rate: $rate, country: $country)';
}


}

/// @nodoc
abstract mixin class $FoodModelCopyWith<$Res>  {
  factory $FoodModelCopyWith(FoodModel value, $Res Function(FoodModel) _then) = _$FoodModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'img') String img,@JsonKey(name: 'name') String name,@JsonKey(name: 'dsc') String? description,@JsonKey(name: 'price', fromJson: _parseDouble) double price,@JsonKey(name: 'rate', fromJson: _parseDoubleNullable) double? rate,@JsonKey(name: 'country') String? country
});




}
/// @nodoc
class _$FoodModelCopyWithImpl<$Res>
    implements $FoodModelCopyWith<$Res> {
  _$FoodModelCopyWithImpl(this._self, this._then);

  final FoodModel _self;
  final $Res Function(FoodModel) _then;

/// Create a copy of FoodModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? img = null,Object? name = null,Object? description = freezed,Object? price = null,Object? rate = freezed,Object? country = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,img: null == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FoodModel].
extension FoodModelPatterns on FoodModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FoodModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FoodModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FoodModel value)  $default,){
final _that = this;
switch (_that) {
case _FoodModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FoodModel value)?  $default,){
final _that = this;
switch (_that) {
case _FoodModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'img')  String img, @JsonKey(name: 'name')  String name, @JsonKey(name: 'dsc')  String? description, @JsonKey(name: 'price', fromJson: _parseDouble)  double price, @JsonKey(name: 'rate', fromJson: _parseDoubleNullable)  double? rate, @JsonKey(name: 'country')  String? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FoodModel() when $default != null:
return $default(_that.id,_that.img,_that.name,_that.description,_that.price,_that.rate,_that.country);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'img')  String img, @JsonKey(name: 'name')  String name, @JsonKey(name: 'dsc')  String? description, @JsonKey(name: 'price', fromJson: _parseDouble)  double price, @JsonKey(name: 'rate', fromJson: _parseDoubleNullable)  double? rate, @JsonKey(name: 'country')  String? country)  $default,) {final _that = this;
switch (_that) {
case _FoodModel():
return $default(_that.id,_that.img,_that.name,_that.description,_that.price,_that.rate,_that.country);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String id, @JsonKey(name: 'img')  String img, @JsonKey(name: 'name')  String name, @JsonKey(name: 'dsc')  String? description, @JsonKey(name: 'price', fromJson: _parseDouble)  double price, @JsonKey(name: 'rate', fromJson: _parseDoubleNullable)  double? rate, @JsonKey(name: 'country')  String? country)?  $default,) {final _that = this;
switch (_that) {
case _FoodModel() when $default != null:
return $default(_that.id,_that.img,_that.name,_that.description,_that.price,_that.rate,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FoodModel implements FoodModel {
  const _FoodModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'img') required this.img, @JsonKey(name: 'name') required this.name, @JsonKey(name: 'dsc') this.description, @JsonKey(name: 'price', fromJson: _parseDouble) this.price = 0.0, @JsonKey(name: 'rate', fromJson: _parseDoubleNullable) this.rate, @JsonKey(name: 'country') this.country});
  factory _FoodModel.fromJson(Map<String, dynamic> json) => _$FoodModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
// ✅ String not int
@override@JsonKey(name: 'img') final  String img;
@override@JsonKey(name: 'name') final  String name;
@override@JsonKey(name: 'dsc') final  String? description;
@override@JsonKey(name: 'price', fromJson: _parseDouble) final  double price;
// ✅ nullable safe
@override@JsonKey(name: 'rate', fromJson: _parseDoubleNullable) final  double? rate;
// ✅ nullable
@override@JsonKey(name: 'country') final  String? country;

/// Create a copy of FoodModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FoodModelCopyWith<_FoodModel> get copyWith => __$FoodModelCopyWithImpl<_FoodModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FoodModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FoodModel&&(identical(other.id, id) || other.id == id)&&(identical(other.img, img) || other.img == img)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,img,name,description,price,rate,country);

@override
String toString() {
  return 'FoodModel(id: $id, img: $img, name: $name, description: $description, price: $price, rate: $rate, country: $country)';
}


}

/// @nodoc
abstract mixin class _$FoodModelCopyWith<$Res> implements $FoodModelCopyWith<$Res> {
  factory _$FoodModelCopyWith(_FoodModel value, $Res Function(_FoodModel) _then) = __$FoodModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'img') String img,@JsonKey(name: 'name') String name,@JsonKey(name: 'dsc') String? description,@JsonKey(name: 'price', fromJson: _parseDouble) double price,@JsonKey(name: 'rate', fromJson: _parseDoubleNullable) double? rate,@JsonKey(name: 'country') String? country
});




}
/// @nodoc
class __$FoodModelCopyWithImpl<$Res>
    implements _$FoodModelCopyWith<$Res> {
  __$FoodModelCopyWithImpl(this._self, this._then);

  final _FoodModel _self;
  final $Res Function(_FoodModel) _then;

/// Create a copy of FoodModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? img = null,Object? name = null,Object? description = freezed,Object? price = null,Object? rate = freezed,Object? country = freezed,}) {
  return _then(_FoodModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,img: null == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
