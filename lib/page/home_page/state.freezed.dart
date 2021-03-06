// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HomeStateTearOff {
  const _$HomeStateTearOff();

// ignore: unused_element
  _HomeState call(
      {@required int tabIndex,
      Token walletSelectedToken,
      PageRoute<dynamic> routeTo,
      bool supernodeUsed,
      bool parachainUsed,
      @required List<Token> displayTokens}) {
    return _HomeState(
      tabIndex: tabIndex,
      walletSelectedToken: walletSelectedToken,
      routeTo: routeTo,
      supernodeUsed: supernodeUsed,
      parachainUsed: parachainUsed,
      displayTokens: displayTokens,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HomeState = _$HomeStateTearOff();

/// @nodoc
mixin _$HomeState {
  int get tabIndex;
  Token get walletSelectedToken;
  PageRoute<dynamic> get routeTo;
  bool get supernodeUsed;
  bool get parachainUsed;
  List<Token> get displayTokens;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res>;
  $Res call(
      {int tabIndex,
      Token walletSelectedToken,
      PageRoute<dynamic> routeTo,
      bool supernodeUsed,
      bool parachainUsed,
      List<Token> displayTokens});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  final HomeState _value;
  // ignore: unused_field
  final $Res Function(HomeState) _then;

  @override
  $Res call({
    Object tabIndex = freezed,
    Object walletSelectedToken = freezed,
    Object routeTo = freezed,
    Object supernodeUsed = freezed,
    Object parachainUsed = freezed,
    Object displayTokens = freezed,
  }) {
    return _then(_value.copyWith(
      tabIndex: tabIndex == freezed ? _value.tabIndex : tabIndex as int,
      walletSelectedToken: walletSelectedToken == freezed
          ? _value.walletSelectedToken
          : walletSelectedToken as Token,
      routeTo:
          routeTo == freezed ? _value.routeTo : routeTo as PageRoute<dynamic>,
      supernodeUsed: supernodeUsed == freezed
          ? _value.supernodeUsed
          : supernodeUsed as bool,
      parachainUsed: parachainUsed == freezed
          ? _value.parachainUsed
          : parachainUsed as bool,
      displayTokens: displayTokens == freezed
          ? _value.displayTokens
          : displayTokens as List<Token>,
    ));
  }
}

/// @nodoc
abstract class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(
          _HomeState value, $Res Function(_HomeState) then) =
      __$HomeStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int tabIndex,
      Token walletSelectedToken,
      PageRoute<dynamic> routeTo,
      bool supernodeUsed,
      bool parachainUsed,
      List<Token> displayTokens});
}

/// @nodoc
class __$HomeStateCopyWithImpl<$Res> extends _$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(_HomeState _value, $Res Function(_HomeState) _then)
      : super(_value, (v) => _then(v as _HomeState));

  @override
  _HomeState get _value => super._value as _HomeState;

  @override
  $Res call({
    Object tabIndex = freezed,
    Object walletSelectedToken = freezed,
    Object routeTo = freezed,
    Object supernodeUsed = freezed,
    Object parachainUsed = freezed,
    Object displayTokens = freezed,
  }) {
    return _then(_HomeState(
      tabIndex: tabIndex == freezed ? _value.tabIndex : tabIndex as int,
      walletSelectedToken: walletSelectedToken == freezed
          ? _value.walletSelectedToken
          : walletSelectedToken as Token,
      routeTo:
          routeTo == freezed ? _value.routeTo : routeTo as PageRoute<dynamic>,
      supernodeUsed: supernodeUsed == freezed
          ? _value.supernodeUsed
          : supernodeUsed as bool,
      parachainUsed: parachainUsed == freezed
          ? _value.parachainUsed
          : parachainUsed as bool,
      displayTokens: displayTokens == freezed
          ? _value.displayTokens
          : displayTokens as List<Token>,
    ));
  }
}

/// @nodoc
class _$_HomeState with DiagnosticableTreeMixin implements _HomeState {
  _$_HomeState(
      {@required this.tabIndex,
      this.walletSelectedToken,
      this.routeTo,
      this.supernodeUsed,
      this.parachainUsed,
      @required this.displayTokens})
      : assert(tabIndex != null),
        assert(displayTokens != null);

  @override
  final int tabIndex;
  @override
  final Token walletSelectedToken;
  @override
  final PageRoute<dynamic> routeTo;
  @override
  final bool supernodeUsed;
  @override
  final bool parachainUsed;
  @override
  final List<Token> displayTokens;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeState(tabIndex: $tabIndex, walletSelectedToken: $walletSelectedToken, routeTo: $routeTo, supernodeUsed: $supernodeUsed, parachainUsed: $parachainUsed, displayTokens: $displayTokens)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeState'))
      ..add(DiagnosticsProperty('tabIndex', tabIndex))
      ..add(DiagnosticsProperty('walletSelectedToken', walletSelectedToken))
      ..add(DiagnosticsProperty('routeTo', routeTo))
      ..add(DiagnosticsProperty('supernodeUsed', supernodeUsed))
      ..add(DiagnosticsProperty('parachainUsed', parachainUsed))
      ..add(DiagnosticsProperty('displayTokens', displayTokens));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HomeState &&
            (identical(other.tabIndex, tabIndex) ||
                const DeepCollectionEquality()
                    .equals(other.tabIndex, tabIndex)) &&
            (identical(other.walletSelectedToken, walletSelectedToken) ||
                const DeepCollectionEquality()
                    .equals(other.walletSelectedToken, walletSelectedToken)) &&
            (identical(other.routeTo, routeTo) ||
                const DeepCollectionEquality()
                    .equals(other.routeTo, routeTo)) &&
            (identical(other.supernodeUsed, supernodeUsed) ||
                const DeepCollectionEquality()
                    .equals(other.supernodeUsed, supernodeUsed)) &&
            (identical(other.parachainUsed, parachainUsed) ||
                const DeepCollectionEquality()
                    .equals(other.parachainUsed, parachainUsed)) &&
            (identical(other.displayTokens, displayTokens) ||
                const DeepCollectionEquality()
                    .equals(other.displayTokens, displayTokens)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tabIndex) ^
      const DeepCollectionEquality().hash(walletSelectedToken) ^
      const DeepCollectionEquality().hash(routeTo) ^
      const DeepCollectionEquality().hash(supernodeUsed) ^
      const DeepCollectionEquality().hash(parachainUsed) ^
      const DeepCollectionEquality().hash(displayTokens);

  @JsonKey(ignore: true)
  @override
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  factory _HomeState(
      {@required int tabIndex,
      Token walletSelectedToken,
      PageRoute<dynamic> routeTo,
      bool supernodeUsed,
      bool parachainUsed,
      @required List<Token> displayTokens}) = _$_HomeState;

  @override
  int get tabIndex;
  @override
  Token get walletSelectedToken;
  @override
  PageRoute<dynamic> get routeTo;
  @override
  bool get supernodeUsed;
  @override
  bool get parachainUsed;
  @override
  List<Token> get displayTokens;
  @override
  @JsonKey(ignore: true)
  _$HomeStateCopyWith<_HomeState> get copyWith;
}
