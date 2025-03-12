// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selectable_earthquake_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectableEarthquakeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(EarthquakeEntity earthquakeEntity) setEarthquake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(EarthquakeEntity earthquakeEntity)? setEarthquake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(EarthquakeEntity earthquakeEntity)? setEarthquake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_SetEarthquake value) setEarthquake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_SetEarthquake value)? setEarthquake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_SetEarthquake value)? setEarthquake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectableEarthquakeEventCopyWith<$Res> {
  factory $SelectableEarthquakeEventCopyWith(SelectableEarthquakeEvent value,
          $Res Function(SelectableEarthquakeEvent) then) =
      _$SelectableEarthquakeEventCopyWithImpl<$Res, SelectableEarthquakeEvent>;
}

/// @nodoc
class _$SelectableEarthquakeEventCopyWithImpl<$Res,
        $Val extends SelectableEarthquakeEvent>
    implements $SelectableEarthquakeEventCopyWith<$Res> {
  _$SelectableEarthquakeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectableEarthquakeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$SelectableEarthquakeEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectableEarthquakeEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'SelectableEarthquakeEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(EarthquakeEntity earthquakeEntity) setEarthquake,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(EarthquakeEntity earthquakeEntity)? setEarthquake,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(EarthquakeEntity earthquakeEntity)? setEarthquake,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_SetEarthquake value) setEarthquake,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_SetEarthquake value)? setEarthquake,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_SetEarthquake value)? setEarthquake,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements SelectableEarthquakeEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$SetEarthquakeImplCopyWith<$Res> {
  factory _$$SetEarthquakeImplCopyWith(
          _$SetEarthquakeImpl value, $Res Function(_$SetEarthquakeImpl) then) =
      __$$SetEarthquakeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EarthquakeEntity earthquakeEntity});
}

/// @nodoc
class __$$SetEarthquakeImplCopyWithImpl<$Res>
    extends _$SelectableEarthquakeEventCopyWithImpl<$Res, _$SetEarthquakeImpl>
    implements _$$SetEarthquakeImplCopyWith<$Res> {
  __$$SetEarthquakeImplCopyWithImpl(
      _$SetEarthquakeImpl _value, $Res Function(_$SetEarthquakeImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectableEarthquakeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquakeEntity = null,
  }) {
    return _then(_$SetEarthquakeImpl(
      null == earthquakeEntity
          ? _value.earthquakeEntity
          : earthquakeEntity // ignore: cast_nullable_to_non_nullable
              as EarthquakeEntity,
    ));
  }
}

/// @nodoc

class _$SetEarthquakeImpl implements _SetEarthquake {
  const _$SetEarthquakeImpl(this.earthquakeEntity);

  @override
  final EarthquakeEntity earthquakeEntity;

  @override
  String toString() {
    return 'SelectableEarthquakeEvent.setEarthquake(earthquakeEntity: $earthquakeEntity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetEarthquakeImpl &&
            (identical(other.earthquakeEntity, earthquakeEntity) ||
                other.earthquakeEntity == earthquakeEntity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, earthquakeEntity);

  /// Create a copy of SelectableEarthquakeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetEarthquakeImplCopyWith<_$SetEarthquakeImpl> get copyWith =>
      __$$SetEarthquakeImplCopyWithImpl<_$SetEarthquakeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(EarthquakeEntity earthquakeEntity) setEarthquake,
  }) {
    return setEarthquake(earthquakeEntity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(EarthquakeEntity earthquakeEntity)? setEarthquake,
  }) {
    return setEarthquake?.call(earthquakeEntity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(EarthquakeEntity earthquakeEntity)? setEarthquake,
    required TResult orElse(),
  }) {
    if (setEarthquake != null) {
      return setEarthquake(earthquakeEntity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_SetEarthquake value) setEarthquake,
  }) {
    return setEarthquake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_SetEarthquake value)? setEarthquake,
  }) {
    return setEarthquake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_SetEarthquake value)? setEarthquake,
    required TResult orElse(),
  }) {
    if (setEarthquake != null) {
      return setEarthquake(this);
    }
    return orElse();
  }
}

abstract class _SetEarthquake implements SelectableEarthquakeEvent {
  const factory _SetEarthquake(final EarthquakeEntity earthquakeEntity) =
      _$SetEarthquakeImpl;

  EarthquakeEntity get earthquakeEntity;

  /// Create a copy of SelectableEarthquakeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetEarthquakeImplCopyWith<_$SetEarthquakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SelectableEarthquakeState {
  BlocState get status => throw _privateConstructorUsedError;
  EarthquakeEntity? get earthquake => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of SelectableEarthquakeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SelectableEarthquakeStateCopyWith<SelectableEarthquakeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectableEarthquakeStateCopyWith<$Res> {
  factory $SelectableEarthquakeStateCopyWith(SelectableEarthquakeState value,
          $Res Function(SelectableEarthquakeState) then) =
      _$SelectableEarthquakeStateCopyWithImpl<$Res, SelectableEarthquakeState>;
  @useResult
  $Res call({BlocState status, EarthquakeEntity? earthquake, String? message});
}

/// @nodoc
class _$SelectableEarthquakeStateCopyWithImpl<$Res,
        $Val extends SelectableEarthquakeState>
    implements $SelectableEarthquakeStateCopyWith<$Res> {
  _$SelectableEarthquakeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SelectableEarthquakeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? earthquake = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocState,
      earthquake: freezed == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeEntity?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $SelectableEarthquakeStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BlocState status, EarthquakeEntity? earthquake, String? message});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SelectableEarthquakeStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SelectableEarthquakeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? earthquake = freezed,
    Object? message = freezed,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocState,
      earthquake: freezed == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeEntity?,
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
      {this.status = BlocState.initial, this.earthquake, this.message});

  @override
  @JsonKey()
  final BlocState status;
  @override
  final EarthquakeEntity? earthquake;
  @override
  final String? message;

  @override
  String toString() {
    return 'SelectableEarthquakeState(status: $status, earthquake: $earthquake, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, earthquake, message);

  /// Create a copy of SelectableEarthquakeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class _Initial implements SelectableEarthquakeState {
  const factory _Initial(
      {final BlocState status,
      final EarthquakeEntity? earthquake,
      final String? message}) = _$InitialImpl;

  @override
  BlocState get status;
  @override
  EarthquakeEntity? get earthquake;
  @override
  String? get message;

  /// Create a copy of SelectableEarthquakeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
