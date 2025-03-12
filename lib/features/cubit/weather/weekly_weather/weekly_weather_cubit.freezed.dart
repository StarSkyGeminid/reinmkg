// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_weather_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeeklyWeatherState {
  BlocState get status => throw _privateConstructorUsedError;
  List<WeatherEntity>? get weathers => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyWeatherState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyWeatherStateCopyWith<WeeklyWeatherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyWeatherStateCopyWith<$Res> {
  factory $WeeklyWeatherStateCopyWith(
          WeeklyWeatherState value, $Res Function(WeeklyWeatherState) then) =
      _$WeeklyWeatherStateCopyWithImpl<$Res, WeeklyWeatherState>;
  @useResult
  $Res call({BlocState status, List<WeatherEntity>? weathers, String? message});
}

/// @nodoc
class _$WeeklyWeatherStateCopyWithImpl<$Res, $Val extends WeeklyWeatherState>
    implements $WeeklyWeatherStateCopyWith<$Res> {
  _$WeeklyWeatherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyWeatherState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? weathers = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocState,
      weathers: freezed == weathers
          ? _value.weathers
          : weathers // ignore: cast_nullable_to_non_nullable
              as List<WeatherEntity>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $WeeklyWeatherStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BlocState status, List<WeatherEntity>? weathers, String? message});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$WeeklyWeatherStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeeklyWeatherState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? weathers = freezed,
    Object? message = freezed,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocState,
      weathers: freezed == weathers
          ? _value._weathers
          : weathers // ignore: cast_nullable_to_non_nullable
              as List<WeatherEntity>?,
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
      final List<WeatherEntity>? weathers,
      this.message})
      : _weathers = weathers;

  @override
  @JsonKey()
  final BlocState status;
  final List<WeatherEntity>? _weathers;
  @override
  List<WeatherEntity>? get weathers {
    final value = _weathers;
    if (value == null) return null;
    if (_weathers is EqualUnmodifiableListView) return _weathers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? message;

  @override
  String toString() {
    return 'WeeklyWeatherState(status: $status, weathers: $weathers, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._weathers, _weathers) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_weathers), message);

  /// Create a copy of WeeklyWeatherState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial implements WeeklyWeatherState {
  const factory _Initial(
      {final BlocState status,
      final List<WeatherEntity>? weathers,
      final String? message}) = _$InitialImpl;

  @override
  BlocState get status;
  @override
  List<WeatherEntity>? get weathers;
  @override
  String? get message;

  /// Create a copy of WeeklyWeatherState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
