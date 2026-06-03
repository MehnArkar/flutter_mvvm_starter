// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaginationData<T> {

 T get data; int get currentPage; bool get hasMorePage; bool get isLoadingMore;
/// Create a copy of PaginationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationDataCopyWith<T, PaginationData<T>> get copyWith => _$PaginationDataCopyWithImpl<T, PaginationData<T>>(this as PaginationData<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationData<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMorePage, hasMorePage) || other.hasMorePage == hasMorePage)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),currentPage,hasMorePage,isLoadingMore);

@override
String toString() {
  return 'PaginationData<$T>(data: $data, currentPage: $currentPage, hasMorePage: $hasMorePage, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $PaginationDataCopyWith<T,$Res>  {
  factory $PaginationDataCopyWith(PaginationData<T> value, $Res Function(PaginationData<T>) _then) = _$PaginationDataCopyWithImpl;
@useResult
$Res call({
 T data, int currentPage, bool hasMorePage, bool isLoadingMore
});




}
/// @nodoc
class _$PaginationDataCopyWithImpl<T,$Res>
    implements $PaginationDataCopyWith<T, $Res> {
  _$PaginationDataCopyWithImpl(this._self, this._then);

  final PaginationData<T> _self;
  final $Res Function(PaginationData<T>) _then;

/// Create a copy of PaginationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,Object? currentPage = null,Object? hasMorePage = null,Object? isLoadingMore = null,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePage: null == hasMorePage ? _self.hasMorePage : hasMorePage // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationData].
extension PaginationDataPatterns<T> on PaginationData<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationData<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationData<T> value)  $default,){
final _that = this;
switch (_that) {
case _PaginationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationData<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T data,  int currentPage,  bool hasMorePage,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationData() when $default != null:
return $default(_that.data,_that.currentPage,_that.hasMorePage,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T data,  int currentPage,  bool hasMorePage,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _PaginationData():
return $default(_that.data,_that.currentPage,_that.hasMorePage,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T data,  int currentPage,  bool hasMorePage,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _PaginationData() when $default != null:
return $default(_that.data,_that.currentPage,_that.hasMorePage,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _PaginationData<T> implements PaginationData<T> {
  const _PaginationData({required this.data, this.currentPage = 0, this.hasMorePage = true, this.isLoadingMore = false});
  

@override final  T data;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool hasMorePage;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of PaginationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationDataCopyWith<T, _PaginationData<T>> get copyWith => __$PaginationDataCopyWithImpl<T, _PaginationData<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationData<T>&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMorePage, hasMorePage) || other.hasMorePage == hasMorePage)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),currentPage,hasMorePage,isLoadingMore);

@override
String toString() {
  return 'PaginationData<$T>(data: $data, currentPage: $currentPage, hasMorePage: $hasMorePage, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$PaginationDataCopyWith<T,$Res> implements $PaginationDataCopyWith<T, $Res> {
  factory _$PaginationDataCopyWith(_PaginationData<T> value, $Res Function(_PaginationData<T>) _then) = __$PaginationDataCopyWithImpl;
@override @useResult
$Res call({
 T data, int currentPage, bool hasMorePage, bool isLoadingMore
});




}
/// @nodoc
class __$PaginationDataCopyWithImpl<T,$Res>
    implements _$PaginationDataCopyWith<T, $Res> {
  __$PaginationDataCopyWithImpl(this._self, this._then);

  final _PaginationData<T> _self;
  final $Res Function(_PaginationData<T>) _then;

/// Create a copy of PaginationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,Object? currentPage = null,Object? hasMorePage = null,Object? isLoadingMore = null,}) {
  return _then(_PaginationData<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePage: null == hasMorePage ? _self.hasMorePage : hasMorePage // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PaginationState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginationState<$T>()';
}


}

/// @nodoc
class $PaginationStateCopyWith<T,$Res>  {
$PaginationStateCopyWith(PaginationState<T> _, $Res Function(PaginationState<T>) __);
}


/// Adds pattern-matching-related methods to [PaginationState].
extension PaginationStatePatterns<T> on PaginationState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaginationInitState<T> value)?  init,TResult Function( PaginationLoadingState<T> value)?  loading,TResult Function( PaginationSuccessState<T> value)?  success,TResult Function( PaginationFailState<T> value)?  fail,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaginationInitState() when init != null:
return init(_that);case PaginationLoadingState() when loading != null:
return loading(_that);case PaginationSuccessState() when success != null:
return success(_that);case PaginationFailState() when fail != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaginationInitState<T> value)  init,required TResult Function( PaginationLoadingState<T> value)  loading,required TResult Function( PaginationSuccessState<T> value)  success,required TResult Function( PaginationFailState<T> value)  fail,}){
final _that = this;
switch (_that) {
case PaginationInitState():
return init(_that);case PaginationLoadingState():
return loading(_that);case PaginationSuccessState():
return success(_that);case PaginationFailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaginationInitState<T> value)?  init,TResult? Function( PaginationLoadingState<T> value)?  loading,TResult? Function( PaginationSuccessState<T> value)?  success,TResult? Function( PaginationFailState<T> value)?  fail,}){
final _that = this;
switch (_that) {
case PaginationInitState() when init != null:
return init(_that);case PaginationLoadingState() when loading != null:
return loading(_that);case PaginationSuccessState() when success != null:
return success(_that);case PaginationFailState() when fail != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  loading,TResult Function( PaginationData<T> paginationData)?  success,TResult Function( Failure failure)?  fail,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaginationInitState() when init != null:
return init();case PaginationLoadingState() when loading != null:
return loading();case PaginationSuccessState() when success != null:
return success(_that.paginationData);case PaginationFailState() when fail != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  loading,required TResult Function( PaginationData<T> paginationData)  success,required TResult Function( Failure failure)  fail,}) {final _that = this;
switch (_that) {
case PaginationInitState():
return init();case PaginationLoadingState():
return loading();case PaginationSuccessState():
return success(_that.paginationData);case PaginationFailState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  loading,TResult? Function( PaginationData<T> paginationData)?  success,TResult? Function( Failure failure)?  fail,}) {final _that = this;
switch (_that) {
case PaginationInitState() when init != null:
return init();case PaginationLoadingState() when loading != null:
return loading();case PaginationSuccessState() when success != null:
return success(_that.paginationData);case PaginationFailState() when fail != null:
return fail(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class PaginationInitState<T> implements PaginationState<T> {
  const PaginationInitState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationInitState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginationState<$T>.init()';
}


}




/// @nodoc


class PaginationLoadingState<T> implements PaginationState<T> {
  const PaginationLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationLoadingState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginationState<$T>.loading()';
}


}




/// @nodoc


class PaginationSuccessState<T> implements PaginationState<T> {
  const PaginationSuccessState(this.paginationData);
  

 final  PaginationData<T> paginationData;

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationSuccessStateCopyWith<T, PaginationSuccessState<T>> get copyWith => _$PaginationSuccessStateCopyWithImpl<T, PaginationSuccessState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationSuccessState<T>&&(identical(other.paginationData, paginationData) || other.paginationData == paginationData));
}


@override
int get hashCode => Object.hash(runtimeType,paginationData);

@override
String toString() {
  return 'PaginationState<$T>.success(paginationData: $paginationData)';
}


}

/// @nodoc
abstract mixin class $PaginationSuccessStateCopyWith<T,$Res> implements $PaginationStateCopyWith<T, $Res> {
  factory $PaginationSuccessStateCopyWith(PaginationSuccessState<T> value, $Res Function(PaginationSuccessState<T>) _then) = _$PaginationSuccessStateCopyWithImpl;
@useResult
$Res call({
 PaginationData<T> paginationData
});


$PaginationDataCopyWith<T, $Res> get paginationData;

}
/// @nodoc
class _$PaginationSuccessStateCopyWithImpl<T,$Res>
    implements $PaginationSuccessStateCopyWith<T, $Res> {
  _$PaginationSuccessStateCopyWithImpl(this._self, this._then);

  final PaginationSuccessState<T> _self;
  final $Res Function(PaginationSuccessState<T>) _then;

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paginationData = null,}) {
  return _then(PaginationSuccessState<T>(
null == paginationData ? _self.paginationData : paginationData // ignore: cast_nullable_to_non_nullable
as PaginationData<T>,
  ));
}

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationDataCopyWith<T, $Res> get paginationData {
  
  return $PaginationDataCopyWith<T, $Res>(_self.paginationData, (value) {
    return _then(_self.copyWith(paginationData: value));
  });
}
}

/// @nodoc


class PaginationFailState<T> implements PaginationState<T> {
  const PaginationFailState(this.failure);
  

 final  Failure failure;

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationFailStateCopyWith<T, PaginationFailState<T>> get copyWith => _$PaginationFailStateCopyWithImpl<T, PaginationFailState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationFailState<T>&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'PaginationState<$T>.fail(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $PaginationFailStateCopyWith<T,$Res> implements $PaginationStateCopyWith<T, $Res> {
  factory $PaginationFailStateCopyWith(PaginationFailState<T> value, $Res Function(PaginationFailState<T>) _then) = _$PaginationFailStateCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$PaginationFailStateCopyWithImpl<T,$Res>
    implements $PaginationFailStateCopyWith<T, $Res> {
  _$PaginationFailStateCopyWithImpl(this._self, this._then);

  final PaginationFailState<T> _self;
  final $Res Function(PaginationFailState<T>) _then;

/// Create a copy of PaginationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(PaginationFailState<T>(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
