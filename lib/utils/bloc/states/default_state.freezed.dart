// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'default_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DefaultState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DefaultState<$T>()';
}


}

/// @nodoc
class $DefaultStateCopyWith<T,$Res>  {
$DefaultStateCopyWith(DefaultState<T> _, $Res Function(DefaultState<T>) __);
}


/// Adds pattern-matching-related methods to [DefaultState].
extension DefaultStatePatterns<T> on DefaultState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DefaultInitState<T> value)?  init,TResult Function( DefaultLoadingState<T> value)?  loading,TResult Function( DefaultSuccessState<T> value)?  success,TResult Function( DefaultFailState<T> value)?  fail,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DefaultInitState() when init != null:
return init(_that);case DefaultLoadingState() when loading != null:
return loading(_that);case DefaultSuccessState() when success != null:
return success(_that);case DefaultFailState() when fail != null:
return fail(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DefaultInitState<T> value)  init,required TResult Function( DefaultLoadingState<T> value)  loading,required TResult Function( DefaultSuccessState<T> value)  success,required TResult Function( DefaultFailState<T> value)  fail,}){
final _that = this;
switch (_that) {
case DefaultInitState():
return init(_that);case DefaultLoadingState():
return loading(_that);case DefaultSuccessState():
return success(_that);case DefaultFailState():
return fail(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DefaultInitState<T> value)?  init,TResult? Function( DefaultLoadingState<T> value)?  loading,TResult? Function( DefaultSuccessState<T> value)?  success,TResult? Function( DefaultFailState<T> value)?  fail,}){
final _that = this;
switch (_that) {
case DefaultInitState() when init != null:
return init(_that);case DefaultLoadingState() when loading != null:
return loading(_that);case DefaultSuccessState() when success != null:
return success(_that);case DefaultFailState() when fail != null:
return fail(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  loading,TResult Function( T data)?  success,TResult Function( Failure failure)?  fail,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DefaultInitState() when init != null:
return init();case DefaultLoadingState() when loading != null:
return loading();case DefaultSuccessState() when success != null:
return success(_that.data);case DefaultFailState() when fail != null:
return fail(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  loading,required TResult Function( T data)  success,required TResult Function( Failure failure)  fail,}) {final _that = this;
switch (_that) {
case DefaultInitState():
return init();case DefaultLoadingState():
return loading();case DefaultSuccessState():
return success(_that.data);case DefaultFailState():
return fail(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  loading,TResult? Function( T data)?  success,TResult? Function( Failure failure)?  fail,}) {final _that = this;
switch (_that) {
case DefaultInitState() when init != null:
return init();case DefaultLoadingState() when loading != null:
return loading();case DefaultSuccessState() when success != null:
return success(_that.data);case DefaultFailState() when fail != null:
return fail(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class DefaultInitState<T> implements DefaultState<T> {
  const DefaultInitState();
  





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultInitState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DefaultState<$T>.init()';
}


}




/// @nodoc


class DefaultLoadingState<T> implements DefaultState<T> {
  const DefaultLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultLoadingState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DefaultState<$T>.loading()';
}


}




/// @nodoc


class DefaultSuccessState<T> implements DefaultState<T> {
  const DefaultSuccessState(this.data);
  

 final  T data;

/// Create a copy of DefaultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefaultSuccessStateCopyWith<T, DefaultSuccessState<T>> get copyWith => _$DefaultSuccessStateCopyWithImpl<T, DefaultSuccessState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultSuccessState<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'DefaultState<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $DefaultSuccessStateCopyWith<T,$Res> implements $DefaultStateCopyWith<T, $Res> {
  factory $DefaultSuccessStateCopyWith(DefaultSuccessState<T> value, $Res Function(DefaultSuccessState<T>) _then) = _$DefaultSuccessStateCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$DefaultSuccessStateCopyWithImpl<T,$Res>
    implements $DefaultSuccessStateCopyWith<T, $Res> {
  _$DefaultSuccessStateCopyWithImpl(this._self, this._then);

  final DefaultSuccessState<T> _self;
  final $Res Function(DefaultSuccessState<T>) _then;

/// Create a copy of DefaultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(DefaultSuccessState<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class DefaultFailState<T> implements DefaultState<T> {
  const DefaultFailState(this.failure);
  

 final  Failure failure;

/// Create a copy of DefaultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefaultFailStateCopyWith<T, DefaultFailState<T>> get copyWith => _$DefaultFailStateCopyWithImpl<T, DefaultFailState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefaultFailState<T>&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'DefaultState<$T>.fail(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $DefaultFailStateCopyWith<T,$Res> implements $DefaultStateCopyWith<T, $Res> {
  factory $DefaultFailStateCopyWith(DefaultFailState<T> value, $Res Function(DefaultFailState<T>) _then) = _$DefaultFailStateCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$DefaultFailStateCopyWithImpl<T,$Res>
    implements $DefaultFailStateCopyWith<T, $Res> {
  _$DefaultFailStateCopyWithImpl(this._self, this._then);

  final DefaultFailState<T> _self;
  final $Res Function(DefaultFailState<T>) _then;

/// Create a copy of DefaultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(DefaultFailState<T>(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
