// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'one_week_earthquakes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OneWeekEarthquakesState {
  BlocState get status => throw _privateConstructorUsedError;
  List<EarthquakeEntity>? get earthquakes => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of OneWeekEarthquakesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OneWeekEarthquakesStateCopyWith<OneWeekEarthquakesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OneWeekEarthquakesStateCopyWith<$Res> {
  factory $OneWeekEarthquakesStateCopyWith(OneWeekEarthquakesState value,
          $Res Function(OneWeekEarthquakesState) then) =
      _$OneWeekEarthquakesStateCopyWithImpl<$Res, OneWeekEarthquakesState>;
  @useResult
  $Res call(
      {BlocState status, List<EarthquakeEntity>? earthquakes, String? message});
}

/// @nodoc
class _$OneWeekEarthquakesStateCopyWithImpl<$Res,
        $Val extends OneWeekEarthquakesState>
    implements $OneWeekEarthquakesStateCopyWith<$Res> {
  _$OneWeekEarthquakesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OneWeekEarthquakesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? earthquakes = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocState,
      earthquakes: freezed == earthquakes
          ? _value.earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEntity>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $OneWeekEarthquakesStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BlocState status, List<EarthquakeEntity>? earthquakes, String? message});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OneWeekEarthquakesStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OneWeekEarthquakesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? earthquakes = freezed,
    Object? message = freezed,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocState,
      earthquakes: freezed == earthquakes
          ? _value._earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<EarthquakeEntity>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.status = BlocState.initial,
      final List<EarthquakeEntity>? earthquakes,
      this.message})
      : _earthquakes = earthquakes;

  @override
  @JsonKey()
  final BlocState status;
  final List<EarthquakeEntity>? _earthquakes;
  @override
  List<EarthquakeEntity>? get earthquakes {
    final value = _earthquakes;
    if (value == null) return null;
    if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? message;

  @override
  String toString() {
    return 'OneWeekEarthquakesState(status: $status, earthquakes: $earthquakes, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._earthquakes, _earthquakes) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_earthquakes), message);

  /// Create a copy of OneWeekEarthquakesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial implements OneWeekEarthquakesState {
  const factory _Initial(
      {final BlocState status,
      final List<EarthquakeEntity>? earthquakes,
      final String? message}) = _$InitialImpl;

  @override
  BlocState get status;
  @override
  List<EarthquakeEntity>? get earthquakes;
  @override
  String? get message;

  /// Create a copy of OneWeekEarthquakesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
