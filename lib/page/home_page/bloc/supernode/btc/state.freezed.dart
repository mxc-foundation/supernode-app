// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SupernodeBtcStateTearOff {
  const _$SupernodeBtcStateTearOff();

// ignore: unused_element
  _SupernodeBtcState call(
      {Wrap<double> balance = const Wrap.pending(),
      Wrap<List<WithdrawHistoryEntity>> withdraws = const Wrap.pending()}) {
    return _SupernodeBtcState(
      balance: balance,
      withdraws: withdraws,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SupernodeBtcState = _$SupernodeBtcStateTearOff();

/// @nodoc
mixin _$SupernodeBtcState {
  Wrap<double> get balance;
  Wrap<List<WithdrawHistoryEntity>> get withdraws;

  @JsonKey(ignore: true)
  $SupernodeBtcStateCopyWith<SupernodeBtcState> get copyWith;
}

/// @nodoc
abstract class $SupernodeBtcStateCopyWith<$Res> {
  factory $SupernodeBtcStateCopyWith(
          SupernodeBtcState value, $Res Function(SupernodeBtcState) then) =
      _$SupernodeBtcStateCopyWithImpl<$Res>;
  $Res call(
      {Wrap<double> balance, Wrap<List<WithdrawHistoryEntity>> withdraws});
}

/// @nodoc
class _$SupernodeBtcStateCopyWithImpl<$Res>
    implements $SupernodeBtcStateCopyWith<$Res> {
  _$SupernodeBtcStateCopyWithImpl(this._value, this._then);

  final SupernodeBtcState _value;
  // ignore: unused_field
  final $Res Function(SupernodeBtcState) _then;

  @override
  $Res call({
    Object balance = freezed,
    Object withdraws = freezed,
  }) {
    return _then(_value.copyWith(
      balance: balance == freezed ? _value.balance : balance as Wrap<double>,
      withdraws: withdraws == freezed
          ? _value.withdraws
          : withdraws as Wrap<List<WithdrawHistoryEntity>>,
    ));
  }
}

/// @nodoc
abstract class _$SupernodeBtcStateCopyWith<$Res>
    implements $SupernodeBtcStateCopyWith<$Res> {
  factory _$SupernodeBtcStateCopyWith(
          _SupernodeBtcState value, $Res Function(_SupernodeBtcState) then) =
      __$SupernodeBtcStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Wrap<double> balance, Wrap<List<WithdrawHistoryEntity>> withdraws});
}

/// @nodoc
class __$SupernodeBtcStateCopyWithImpl<$Res>
    extends _$SupernodeBtcStateCopyWithImpl<$Res>
    implements _$SupernodeBtcStateCopyWith<$Res> {
  __$SupernodeBtcStateCopyWithImpl(
      _SupernodeBtcState _value, $Res Function(_SupernodeBtcState) _then)
      : super(_value, (v) => _then(v as _SupernodeBtcState));

  @override
  _SupernodeBtcState get _value => super._value as _SupernodeBtcState;

  @override
  $Res call({
    Object balance = freezed,
    Object withdraws = freezed,
  }) {
    return _then(_SupernodeBtcState(
      balance: balance == freezed ? _value.balance : balance as Wrap<double>,
      withdraws: withdraws == freezed
          ? _value.withdraws
          : withdraws as Wrap<List<WithdrawHistoryEntity>>,
    ));
  }
}

/// @nodoc
class _$_SupernodeBtcState
    with DiagnosticableTreeMixin
    implements _SupernodeBtcState {
  _$_SupernodeBtcState(
      {this.balance = const Wrap.pending(),
      this.withdraws = const Wrap.pending()})
      : assert(balance != null),
        assert(withdraws != null);

  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> balance;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<WithdrawHistoryEntity>> withdraws;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SupernodeBtcState(balance: $balance, withdraws: $withdraws)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SupernodeBtcState'))
      ..add(DiagnosticsProperty('balance', balance))
      ..add(DiagnosticsProperty('withdraws', withdraws));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SupernodeBtcState &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality()
                    .equals(other.balance, balance)) &&
            (identical(other.withdraws, withdraws) ||
                const DeepCollectionEquality()
                    .equals(other.withdraws, withdraws)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(withdraws);

  @JsonKey(ignore: true)
  @override
  _$SupernodeBtcStateCopyWith<_SupernodeBtcState> get copyWith =>
      __$SupernodeBtcStateCopyWithImpl<_SupernodeBtcState>(this, _$identity);
}

abstract class _SupernodeBtcState implements SupernodeBtcState {
  factory _SupernodeBtcState(
      {Wrap<double> balance,
      Wrap<List<WithdrawHistoryEntity>> withdraws}) = _$_SupernodeBtcState;

  @override
  Wrap<double> get balance;
  @override
  Wrap<List<WithdrawHistoryEntity>> get withdraws;
  @override
  @JsonKey(ignore: true)
  _$SupernodeBtcStateCopyWith<_SupernodeBtcState> get copyWith;
}
