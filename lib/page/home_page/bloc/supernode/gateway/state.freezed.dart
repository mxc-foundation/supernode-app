// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GatewayStateTearOff {
  const _$GatewayStateTearOff();

// ignore: unused_element
  _GatewayState call(
      {Wrap<int> gatewaysTotal = const Wrap.pending(),
      Wrap<List<GatewayItem>> gateways = const Wrap.pending(),
      List<MinerHealthResponse> listMinersHealth,
      Wrap<double> health = const Wrap.pending(),
      Wrap<double> uptimeHealth = const Wrap.pending(),
      Wrap<double> miningFuelHealth = const Wrap.pending(),
      Wrap<double> miningFuel = const Wrap.pending(),
      Wrap<double> miningFuelMax = const Wrap.pending(),
      GatewayItem selectedGateway,
      double downlinkPrice,
      List<GatewayStatisticResponse> framesLast7days,
      List<DailyStatistic> statsLast7days,
      double sumMiningRevenueLast7days,
      int sumSecondsOnlineLast7days = 0,
      int secondsLast7days = 1}) {
    return _GatewayState(
      gatewaysTotal: gatewaysTotal,
      gateways: gateways,
      listMinersHealth: listMinersHealth,
      health: health,
      uptimeHealth: uptimeHealth,
      miningFuelHealth: miningFuelHealth,
      miningFuel: miningFuel,
      miningFuelMax: miningFuelMax,
      selectedGateway: selectedGateway,
      downlinkPrice: downlinkPrice,
      framesLast7days: framesLast7days,
      statsLast7days: statsLast7days,
      sumMiningRevenueLast7days: sumMiningRevenueLast7days,
      sumSecondsOnlineLast7days: sumSecondsOnlineLast7days,
      secondsLast7days: secondsLast7days,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GatewayState = _$GatewayStateTearOff();

/// @nodoc
mixin _$GatewayState {
  Wrap<int> get gatewaysTotal;
  Wrap<List<GatewayItem>> get gateways;
  List<MinerHealthResponse> get listMinersHealth;
  Wrap<double> get health;
  Wrap<double> get uptimeHealth;
  Wrap<double> get miningFuelHealth;
  Wrap<double> get miningFuel;
  Wrap<double> get miningFuelMax;
  GatewayItem get selectedGateway;
  double get downlinkPrice;
  List<GatewayStatisticResponse> get framesLast7days;
  List<DailyStatistic> get statsLast7days;
  double get sumMiningRevenueLast7days;
  int get sumSecondsOnlineLast7days;
  int get secondsLast7days;

  @JsonKey(ignore: true)
  $GatewayStateCopyWith<GatewayState> get copyWith;
}

/// @nodoc
abstract class $GatewayStateCopyWith<$Res> {
  factory $GatewayStateCopyWith(
          GatewayState value, $Res Function(GatewayState) then) =
      _$GatewayStateCopyWithImpl<$Res>;
  $Res call(
      {Wrap<int> gatewaysTotal,
      Wrap<List<GatewayItem>> gateways,
      List<MinerHealthResponse> listMinersHealth,
      Wrap<double> health,
      Wrap<double> uptimeHealth,
      Wrap<double> miningFuelHealth,
      Wrap<double> miningFuel,
      Wrap<double> miningFuelMax,
      GatewayItem selectedGateway,
      double downlinkPrice,
      List<GatewayStatisticResponse> framesLast7days,
      List<DailyStatistic> statsLast7days,
      double sumMiningRevenueLast7days,
      int sumSecondsOnlineLast7days,
      int secondsLast7days});

  $GatewayItemCopyWith<$Res> get selectedGateway;
}

/// @nodoc
class _$GatewayStateCopyWithImpl<$Res> implements $GatewayStateCopyWith<$Res> {
  _$GatewayStateCopyWithImpl(this._value, this._then);

  final GatewayState _value;
  // ignore: unused_field
  final $Res Function(GatewayState) _then;

  @override
  $Res call({
    Object gatewaysTotal = freezed,
    Object gateways = freezed,
    Object listMinersHealth = freezed,
    Object health = freezed,
    Object uptimeHealth = freezed,
    Object miningFuelHealth = freezed,
    Object miningFuel = freezed,
    Object miningFuelMax = freezed,
    Object selectedGateway = freezed,
    Object downlinkPrice = freezed,
    Object framesLast7days = freezed,
    Object statsLast7days = freezed,
    Object sumMiningRevenueLast7days = freezed,
    Object sumSecondsOnlineLast7days = freezed,
    Object secondsLast7days = freezed,
  }) {
    return _then(_value.copyWith(
      gatewaysTotal: gatewaysTotal == freezed
          ? _value.gatewaysTotal
          : gatewaysTotal as Wrap<int>,
      gateways: gateways == freezed
          ? _value.gateways
          : gateways as Wrap<List<GatewayItem>>,
      listMinersHealth: listMinersHealth == freezed
          ? _value.listMinersHealth
          : listMinersHealth as List<MinerHealthResponse>,
      health: health == freezed ? _value.health : health as Wrap<double>,
      uptimeHealth: uptimeHealth == freezed
          ? _value.uptimeHealth
          : uptimeHealth as Wrap<double>,
      miningFuelHealth: miningFuelHealth == freezed
          ? _value.miningFuelHealth
          : miningFuelHealth as Wrap<double>,
      miningFuel: miningFuel == freezed
          ? _value.miningFuel
          : miningFuel as Wrap<double>,
      miningFuelMax: miningFuelMax == freezed
          ? _value.miningFuelMax
          : miningFuelMax as Wrap<double>,
      selectedGateway: selectedGateway == freezed
          ? _value.selectedGateway
          : selectedGateway as GatewayItem,
      downlinkPrice: downlinkPrice == freezed
          ? _value.downlinkPrice
          : downlinkPrice as double,
      framesLast7days: framesLast7days == freezed
          ? _value.framesLast7days
          : framesLast7days as List<GatewayStatisticResponse>,
      statsLast7days: statsLast7days == freezed
          ? _value.statsLast7days
          : statsLast7days as List<DailyStatistic>,
      sumMiningRevenueLast7days: sumMiningRevenueLast7days == freezed
          ? _value.sumMiningRevenueLast7days
          : sumMiningRevenueLast7days as double,
      sumSecondsOnlineLast7days: sumSecondsOnlineLast7days == freezed
          ? _value.sumSecondsOnlineLast7days
          : sumSecondsOnlineLast7days as int,
      secondsLast7days: secondsLast7days == freezed
          ? _value.secondsLast7days
          : secondsLast7days as int,
    ));
  }

  @override
  $GatewayItemCopyWith<$Res> get selectedGateway {
    if (_value.selectedGateway == null) {
      return null;
    }
    return $GatewayItemCopyWith<$Res>(_value.selectedGateway, (value) {
      return _then(_value.copyWith(selectedGateway: value));
    });
  }
}

/// @nodoc
abstract class _$GatewayStateCopyWith<$Res>
    implements $GatewayStateCopyWith<$Res> {
  factory _$GatewayStateCopyWith(
          _GatewayState value, $Res Function(_GatewayState) then) =
      __$GatewayStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Wrap<int> gatewaysTotal,
      Wrap<List<GatewayItem>> gateways,
      List<MinerHealthResponse> listMinersHealth,
      Wrap<double> health,
      Wrap<double> uptimeHealth,
      Wrap<double> miningFuelHealth,
      Wrap<double> miningFuel,
      Wrap<double> miningFuelMax,
      GatewayItem selectedGateway,
      double downlinkPrice,
      List<GatewayStatisticResponse> framesLast7days,
      List<DailyStatistic> statsLast7days,
      double sumMiningRevenueLast7days,
      int sumSecondsOnlineLast7days,
      int secondsLast7days});

  @override
  $GatewayItemCopyWith<$Res> get selectedGateway;
}

/// @nodoc
class __$GatewayStateCopyWithImpl<$Res> extends _$GatewayStateCopyWithImpl<$Res>
    implements _$GatewayStateCopyWith<$Res> {
  __$GatewayStateCopyWithImpl(
      _GatewayState _value, $Res Function(_GatewayState) _then)
      : super(_value, (v) => _then(v as _GatewayState));

  @override
  _GatewayState get _value => super._value as _GatewayState;

  @override
  $Res call({
    Object gatewaysTotal = freezed,
    Object gateways = freezed,
    Object listMinersHealth = freezed,
    Object health = freezed,
    Object uptimeHealth = freezed,
    Object miningFuelHealth = freezed,
    Object miningFuel = freezed,
    Object miningFuelMax = freezed,
    Object selectedGateway = freezed,
    Object downlinkPrice = freezed,
    Object framesLast7days = freezed,
    Object statsLast7days = freezed,
    Object sumMiningRevenueLast7days = freezed,
    Object sumSecondsOnlineLast7days = freezed,
    Object secondsLast7days = freezed,
  }) {
    return _then(_GatewayState(
      gatewaysTotal: gatewaysTotal == freezed
          ? _value.gatewaysTotal
          : gatewaysTotal as Wrap<int>,
      gateways: gateways == freezed
          ? _value.gateways
          : gateways as Wrap<List<GatewayItem>>,
      listMinersHealth: listMinersHealth == freezed
          ? _value.listMinersHealth
          : listMinersHealth as List<MinerHealthResponse>,
      health: health == freezed ? _value.health : health as Wrap<double>,
      uptimeHealth: uptimeHealth == freezed
          ? _value.uptimeHealth
          : uptimeHealth as Wrap<double>,
      miningFuelHealth: miningFuelHealth == freezed
          ? _value.miningFuelHealth
          : miningFuelHealth as Wrap<double>,
      miningFuel: miningFuel == freezed
          ? _value.miningFuel
          : miningFuel as Wrap<double>,
      miningFuelMax: miningFuelMax == freezed
          ? _value.miningFuelMax
          : miningFuelMax as Wrap<double>,
      selectedGateway: selectedGateway == freezed
          ? _value.selectedGateway
          : selectedGateway as GatewayItem,
      downlinkPrice: downlinkPrice == freezed
          ? _value.downlinkPrice
          : downlinkPrice as double,
      framesLast7days: framesLast7days == freezed
          ? _value.framesLast7days
          : framesLast7days as List<GatewayStatisticResponse>,
      statsLast7days: statsLast7days == freezed
          ? _value.statsLast7days
          : statsLast7days as List<DailyStatistic>,
      sumMiningRevenueLast7days: sumMiningRevenueLast7days == freezed
          ? _value.sumMiningRevenueLast7days
          : sumMiningRevenueLast7days as double,
      sumSecondsOnlineLast7days: sumSecondsOnlineLast7days == freezed
          ? _value.sumSecondsOnlineLast7days
          : sumSecondsOnlineLast7days as int,
      secondsLast7days: secondsLast7days == freezed
          ? _value.secondsLast7days
          : secondsLast7days as int,
    ));
  }
}

/// @nodoc
class _$_GatewayState with DiagnosticableTreeMixin implements _GatewayState {
  _$_GatewayState(
      {this.gatewaysTotal = const Wrap.pending(),
      this.gateways = const Wrap.pending(),
      this.listMinersHealth,
      this.health = const Wrap.pending(),
      this.uptimeHealth = const Wrap.pending(),
      this.miningFuelHealth = const Wrap.pending(),
      this.miningFuel = const Wrap.pending(),
      this.miningFuelMax = const Wrap.pending(),
      this.selectedGateway,
      this.downlinkPrice,
      this.framesLast7days,
      this.statsLast7days,
      this.sumMiningRevenueLast7days,
      this.sumSecondsOnlineLast7days = 0,
      this.secondsLast7days = 1})
      : assert(gatewaysTotal != null),
        assert(gateways != null),
        assert(health != null),
        assert(uptimeHealth != null),
        assert(miningFuelHealth != null),
        assert(miningFuel != null),
        assert(miningFuelMax != null),
        assert(sumSecondsOnlineLast7days != null),
        assert(secondsLast7days != null);

  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<int> gatewaysTotal;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<List<GatewayItem>> gateways;
  @override
  final List<MinerHealthResponse> listMinersHealth;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> health;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> uptimeHealth;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> miningFuelHealth;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> miningFuel;
  @JsonKey(defaultValue: const Wrap.pending())
  @override
  final Wrap<double> miningFuelMax;
  @override
  final GatewayItem selectedGateway;
  @override
  final double downlinkPrice;
  @override
  final List<GatewayStatisticResponse> framesLast7days;
  @override
  final List<DailyStatistic> statsLast7days;
  @override
  final double sumMiningRevenueLast7days;
  @JsonKey(defaultValue: 0)
  @override
  final int sumSecondsOnlineLast7days;
  @JsonKey(defaultValue: 1)
  @override
  final int secondsLast7days;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GatewayState(gatewaysTotal: $gatewaysTotal, gateways: $gateways, listMinersHealth: $listMinersHealth, health: $health, uptimeHealth: $uptimeHealth, miningFuelHealth: $miningFuelHealth, miningFuel: $miningFuel, miningFuelMax: $miningFuelMax, selectedGateway: $selectedGateway, downlinkPrice: $downlinkPrice, framesLast7days: $framesLast7days, statsLast7days: $statsLast7days, sumMiningRevenueLast7days: $sumMiningRevenueLast7days, sumSecondsOnlineLast7days: $sumSecondsOnlineLast7days, secondsLast7days: $secondsLast7days)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GatewayState'))
      ..add(DiagnosticsProperty('gatewaysTotal', gatewaysTotal))
      ..add(DiagnosticsProperty('gateways', gateways))
      ..add(DiagnosticsProperty('listMinersHealth', listMinersHealth))
      ..add(DiagnosticsProperty('health', health))
      ..add(DiagnosticsProperty('uptimeHealth', uptimeHealth))
      ..add(DiagnosticsProperty('miningFuelHealth', miningFuelHealth))
      ..add(DiagnosticsProperty('miningFuel', miningFuel))
      ..add(DiagnosticsProperty('miningFuelMax', miningFuelMax))
      ..add(DiagnosticsProperty('selectedGateway', selectedGateway))
      ..add(DiagnosticsProperty('downlinkPrice', downlinkPrice))
      ..add(DiagnosticsProperty('framesLast7days', framesLast7days))
      ..add(DiagnosticsProperty('statsLast7days', statsLast7days))
      ..add(DiagnosticsProperty(
          'sumMiningRevenueLast7days', sumMiningRevenueLast7days))
      ..add(DiagnosticsProperty(
          'sumSecondsOnlineLast7days', sumSecondsOnlineLast7days))
      ..add(DiagnosticsProperty('secondsLast7days', secondsLast7days));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GatewayState &&
            (identical(other.gatewaysTotal, gatewaysTotal) ||
                const DeepCollectionEquality()
                    .equals(other.gatewaysTotal, gatewaysTotal)) &&
            (identical(other.gateways, gateways) ||
                const DeepCollectionEquality()
                    .equals(other.gateways, gateways)) &&
            (identical(other.listMinersHealth, listMinersHealth) ||
                const DeepCollectionEquality()
                    .equals(other.listMinersHealth, listMinersHealth)) &&
            (identical(other.health, health) ||
                const DeepCollectionEquality().equals(other.health, health)) &&
            (identical(other.uptimeHealth, uptimeHealth) ||
                const DeepCollectionEquality()
                    .equals(other.uptimeHealth, uptimeHealth)) &&
            (identical(other.miningFuelHealth, miningFuelHealth) ||
                const DeepCollectionEquality()
                    .equals(other.miningFuelHealth, miningFuelHealth)) &&
            (identical(other.miningFuel, miningFuel) ||
                const DeepCollectionEquality()
                    .equals(other.miningFuel, miningFuel)) &&
            (identical(other.miningFuelMax, miningFuelMax) ||
                const DeepCollectionEquality()
                    .equals(other.miningFuelMax, miningFuelMax)) &&
            (identical(other.selectedGateway, selectedGateway) ||
                const DeepCollectionEquality()
                    .equals(other.selectedGateway, selectedGateway)) &&
            (identical(other.downlinkPrice, downlinkPrice) ||
                const DeepCollectionEquality()
                    .equals(other.downlinkPrice, downlinkPrice)) &&
            (identical(other.framesLast7days, framesLast7days) ||
                const DeepCollectionEquality()
                    .equals(other.framesLast7days, framesLast7days)) &&
            (identical(other.statsLast7days, statsLast7days) ||
                const DeepCollectionEquality()
                    .equals(other.statsLast7days, statsLast7days)) &&
            (identical(other.sumMiningRevenueLast7days,
                    sumMiningRevenueLast7days) ||
                const DeepCollectionEquality().equals(
                    other.sumMiningRevenueLast7days,
                    sumMiningRevenueLast7days)) &&
            (identical(other.sumSecondsOnlineLast7days,
                    sumSecondsOnlineLast7days) ||
                const DeepCollectionEquality().equals(
                    other.sumSecondsOnlineLast7days,
                    sumSecondsOnlineLast7days)) &&
            (identical(other.secondsLast7days, secondsLast7days) ||
                const DeepCollectionEquality()
                    .equals(other.secondsLast7days, secondsLast7days)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(gatewaysTotal) ^
      const DeepCollectionEquality().hash(gateways) ^
      const DeepCollectionEquality().hash(listMinersHealth) ^
      const DeepCollectionEquality().hash(health) ^
      const DeepCollectionEquality().hash(uptimeHealth) ^
      const DeepCollectionEquality().hash(miningFuelHealth) ^
      const DeepCollectionEquality().hash(miningFuel) ^
      const DeepCollectionEquality().hash(miningFuelMax) ^
      const DeepCollectionEquality().hash(selectedGateway) ^
      const DeepCollectionEquality().hash(downlinkPrice) ^
      const DeepCollectionEquality().hash(framesLast7days) ^
      const DeepCollectionEquality().hash(statsLast7days) ^
      const DeepCollectionEquality().hash(sumMiningRevenueLast7days) ^
      const DeepCollectionEquality().hash(sumSecondsOnlineLast7days) ^
      const DeepCollectionEquality().hash(secondsLast7days);

  @JsonKey(ignore: true)
  @override
  _$GatewayStateCopyWith<_GatewayState> get copyWith =>
      __$GatewayStateCopyWithImpl<_GatewayState>(this, _$identity);
}

abstract class _GatewayState implements GatewayState {
  factory _GatewayState(
      {Wrap<int> gatewaysTotal,
      Wrap<List<GatewayItem>> gateways,
      List<MinerHealthResponse> listMinersHealth,
      Wrap<double> health,
      Wrap<double> uptimeHealth,
      Wrap<double> miningFuelHealth,
      Wrap<double> miningFuel,
      Wrap<double> miningFuelMax,
      GatewayItem selectedGateway,
      double downlinkPrice,
      List<GatewayStatisticResponse> framesLast7days,
      List<DailyStatistic> statsLast7days,
      double sumMiningRevenueLast7days,
      int sumSecondsOnlineLast7days,
      int secondsLast7days}) = _$_GatewayState;

  @override
  Wrap<int> get gatewaysTotal;
  @override
  Wrap<List<GatewayItem>> get gateways;
  @override
  List<MinerHealthResponse> get listMinersHealth;
  @override
  Wrap<double> get health;
  @override
  Wrap<double> get uptimeHealth;
  @override
  Wrap<double> get miningFuelHealth;
  @override
  Wrap<double> get miningFuel;
  @override
  Wrap<double> get miningFuelMax;
  @override
  GatewayItem get selectedGateway;
  @override
  double get downlinkPrice;
  @override
  List<GatewayStatisticResponse> get framesLast7days;
  @override
  List<DailyStatistic> get statsLast7days;
  @override
  double get sumMiningRevenueLast7days;
  @override
  int get sumSecondsOnlineLast7days;
  @override
  int get secondsLast7days;
  @override
  @JsonKey(ignore: true)
  _$GatewayStateCopyWith<_GatewayState> get copyWith;
}

GatewayItem _$GatewayItemFromJson(Map<String, dynamic> json) {
  return _GatewayItem.fromJson(json);
}

/// @nodoc
class _$GatewayItemTearOff {
  const _$GatewayItemTearOff();

// ignore: unused_element
  _GatewayItem call(
      {@required
          String id,
      @required
          String name,
      @required
          String description,
      @required
          Map<dynamic, dynamic> location,
      @required
      @JsonKey(name: 'organizationID')
          String organizationId,
      @required
      @JsonKey(name: 'networkServerID')
          String networkServerId,
      @required
          String createdAt,
      @nullable
          String updatedAt,
      @nullable
          String firstSeenAt,
      @nullable
          String lastSeenAt,
      @nullable
          String model,
      @nullable
          String osversion,
      @nullable
          double health,
      @nullable
          double uptimeHealth,
      @nullable
          double miningFuelHealth,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuel,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuelMax,
      @nullable
          double totalMined,
      bool reseller = false}) {
    return _GatewayItem(
      id: id,
      name: name,
      description: description,
      location: location,
      organizationId: organizationId,
      networkServerId: networkServerId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      firstSeenAt: firstSeenAt,
      lastSeenAt: lastSeenAt,
      model: model,
      osversion: osversion,
      health: health,
      uptimeHealth: uptimeHealth,
      miningFuelHealth: miningFuelHealth,
      miningFuel: miningFuel,
      miningFuelMax: miningFuelMax,
      totalMined: totalMined,
      reseller: reseller,
    );
  }

// ignore: unused_element
  GatewayItem fromJson(Map<String, Object> json) {
    return GatewayItem.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $GatewayItem = _$GatewayItemTearOff();

/// @nodoc
mixin _$GatewayItem {
  String get id;
  String get name;
  String get description;
  Map<dynamic, dynamic> get location; // RETHINK.TODO - remove map
  @JsonKey(name: 'organizationID')
  String get organizationId;
  @JsonKey(name: 'networkServerID')
  String get networkServerId;
  String get createdAt;
  @nullable
  String get updatedAt;
  @nullable
  String get firstSeenAt;
  @nullable
  String get lastSeenAt;
  @nullable
  String get model;
  @nullable
  String get osversion;
  @nullable
  double get health;
  @nullable
  double get uptimeHealth;
  @nullable
  double get miningFuelHealth;
  @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
  @nullable
  Decimal get miningFuel;
  @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
  @nullable
  Decimal get miningFuelMax;
  @nullable
  double get totalMined;
  bool get reseller;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $GatewayItemCopyWith<GatewayItem> get copyWith;
}

/// @nodoc
abstract class $GatewayItemCopyWith<$Res> {
  factory $GatewayItemCopyWith(
          GatewayItem value, $Res Function(GatewayItem) then) =
      _$GatewayItemCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String description,
      Map<dynamic, dynamic> location,
      @JsonKey(name: 'organizationID')
          String organizationId,
      @JsonKey(name: 'networkServerID')
          String networkServerId,
      String createdAt,
      @nullable
          String updatedAt,
      @nullable
          String firstSeenAt,
      @nullable
          String lastSeenAt,
      @nullable
          String model,
      @nullable
          String osversion,
      @nullable
          double health,
      @nullable
          double uptimeHealth,
      @nullable
          double miningFuelHealth,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuel,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuelMax,
      @nullable
          double totalMined,
      bool reseller});
}

/// @nodoc
class _$GatewayItemCopyWithImpl<$Res> implements $GatewayItemCopyWith<$Res> {
  _$GatewayItemCopyWithImpl(this._value, this._then);

  final GatewayItem _value;
  // ignore: unused_field
  final $Res Function(GatewayItem) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object description = freezed,
    Object location = freezed,
    Object organizationId = freezed,
    Object networkServerId = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object firstSeenAt = freezed,
    Object lastSeenAt = freezed,
    Object model = freezed,
    Object osversion = freezed,
    Object health = freezed,
    Object uptimeHealth = freezed,
    Object miningFuelHealth = freezed,
    Object miningFuel = freezed,
    Object miningFuelMax = freezed,
    Object totalMined = freezed,
    Object reseller = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      location: location == freezed
          ? _value.location
          : location as Map<dynamic, dynamic>,
      organizationId: organizationId == freezed
          ? _value.organizationId
          : organizationId as String,
      networkServerId: networkServerId == freezed
          ? _value.networkServerId
          : networkServerId as String,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      firstSeenAt:
          firstSeenAt == freezed ? _value.firstSeenAt : firstSeenAt as String,
      lastSeenAt:
          lastSeenAt == freezed ? _value.lastSeenAt : lastSeenAt as String,
      model: model == freezed ? _value.model : model as String,
      osversion: osversion == freezed ? _value.osversion : osversion as String,
      health: health == freezed ? _value.health : health as double,
      uptimeHealth: uptimeHealth == freezed
          ? _value.uptimeHealth
          : uptimeHealth as double,
      miningFuelHealth: miningFuelHealth == freezed
          ? _value.miningFuelHealth
          : miningFuelHealth as double,
      miningFuel:
          miningFuel == freezed ? _value.miningFuel : miningFuel as Decimal,
      miningFuelMax: miningFuelMax == freezed
          ? _value.miningFuelMax
          : miningFuelMax as Decimal,
      totalMined:
          totalMined == freezed ? _value.totalMined : totalMined as double,
      reseller: reseller == freezed ? _value.reseller : reseller as bool,
    ));
  }
}

/// @nodoc
abstract class _$GatewayItemCopyWith<$Res>
    implements $GatewayItemCopyWith<$Res> {
  factory _$GatewayItemCopyWith(
          _GatewayItem value, $Res Function(_GatewayItem) then) =
      __$GatewayItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String description,
      Map<dynamic, dynamic> location,
      @JsonKey(name: 'organizationID')
          String organizationId,
      @JsonKey(name: 'networkServerID')
          String networkServerId,
      String createdAt,
      @nullable
          String updatedAt,
      @nullable
          String firstSeenAt,
      @nullable
          String lastSeenAt,
      @nullable
          String model,
      @nullable
          String osversion,
      @nullable
          double health,
      @nullable
          double uptimeHealth,
      @nullable
          double miningFuelHealth,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuel,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuelMax,
      @nullable
          double totalMined,
      bool reseller});
}

/// @nodoc
class __$GatewayItemCopyWithImpl<$Res> extends _$GatewayItemCopyWithImpl<$Res>
    implements _$GatewayItemCopyWith<$Res> {
  __$GatewayItemCopyWithImpl(
      _GatewayItem _value, $Res Function(_GatewayItem) _then)
      : super(_value, (v) => _then(v as _GatewayItem));

  @override
  _GatewayItem get _value => super._value as _GatewayItem;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object description = freezed,
    Object location = freezed,
    Object organizationId = freezed,
    Object networkServerId = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
    Object firstSeenAt = freezed,
    Object lastSeenAt = freezed,
    Object model = freezed,
    Object osversion = freezed,
    Object health = freezed,
    Object uptimeHealth = freezed,
    Object miningFuelHealth = freezed,
    Object miningFuel = freezed,
    Object miningFuelMax = freezed,
    Object totalMined = freezed,
    Object reseller = freezed,
  }) {
    return _then(_GatewayItem(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      location: location == freezed
          ? _value.location
          : location as Map<dynamic, dynamic>,
      organizationId: organizationId == freezed
          ? _value.organizationId
          : organizationId as String,
      networkServerId: networkServerId == freezed
          ? _value.networkServerId
          : networkServerId as String,
      createdAt: createdAt == freezed ? _value.createdAt : createdAt as String,
      updatedAt: updatedAt == freezed ? _value.updatedAt : updatedAt as String,
      firstSeenAt:
          firstSeenAt == freezed ? _value.firstSeenAt : firstSeenAt as String,
      lastSeenAt:
          lastSeenAt == freezed ? _value.lastSeenAt : lastSeenAt as String,
      model: model == freezed ? _value.model : model as String,
      osversion: osversion == freezed ? _value.osversion : osversion as String,
      health: health == freezed ? _value.health : health as double,
      uptimeHealth: uptimeHealth == freezed
          ? _value.uptimeHealth
          : uptimeHealth as double,
      miningFuelHealth: miningFuelHealth == freezed
          ? _value.miningFuelHealth
          : miningFuelHealth as double,
      miningFuel:
          miningFuel == freezed ? _value.miningFuel : miningFuel as Decimal,
      miningFuelMax: miningFuelMax == freezed
          ? _value.miningFuelMax
          : miningFuelMax as Decimal,
      totalMined:
          totalMined == freezed ? _value.totalMined : totalMined as double,
      reseller: reseller == freezed ? _value.reseller : reseller as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_GatewayItem with DiagnosticableTreeMixin implements _GatewayItem {
  _$_GatewayItem(
      {@required
          this.id,
      @required
          this.name,
      @required
          this.description,
      @required
          this.location,
      @required
      @JsonKey(name: 'organizationID')
          this.organizationId,
      @required
      @JsonKey(name: 'networkServerID')
          this.networkServerId,
      @required
          this.createdAt,
      @nullable
          this.updatedAt,
      @nullable
          this.firstSeenAt,
      @nullable
          this.lastSeenAt,
      @nullable
          this.model,
      @nullable
          this.osversion,
      @nullable
          this.health,
      @nullable
          this.uptimeHealth,
      @nullable
          this.miningFuelHealth,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          this.miningFuel,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          this.miningFuelMax,
      @nullable
          this.totalMined,
      this.reseller = false})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(location != null),
        assert(organizationId != null),
        assert(networkServerId != null),
        assert(createdAt != null),
        assert(reseller != null);

  factory _$_GatewayItem.fromJson(Map<String, dynamic> json) =>
      _$_$_GatewayItemFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final Map<dynamic, dynamic> location;
  @override // RETHINK.TODO - remove map
  @JsonKey(name: 'organizationID')
  final String organizationId;
  @override
  @JsonKey(name: 'networkServerID')
  final String networkServerId;
  @override
  final String createdAt;
  @override
  @nullable
  final String updatedAt;
  @override
  @nullable
  final String firstSeenAt;
  @override
  @nullable
  final String lastSeenAt;
  @override
  @nullable
  final String model;
  @override
  @nullable
  final String osversion;
  @override
  @nullable
  final double health;
  @override
  @nullable
  final double uptimeHealth;
  @override
  @nullable
  final double miningFuelHealth;
  @override
  @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
  @nullable
  final Decimal miningFuel;
  @override
  @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
  @nullable
  final Decimal miningFuelMax;
  @override
  @nullable
  final double totalMined;
  @JsonKey(defaultValue: false)
  @override
  final bool reseller;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GatewayItem(id: $id, name: $name, description: $description, location: $location, organizationId: $organizationId, networkServerId: $networkServerId, createdAt: $createdAt, updatedAt: $updatedAt, firstSeenAt: $firstSeenAt, lastSeenAt: $lastSeenAt, model: $model, osversion: $osversion, health: $health, uptimeHealth: $uptimeHealth, miningFuelHealth: $miningFuelHealth, miningFuel: $miningFuel, miningFuelMax: $miningFuelMax, totalMined: $totalMined, reseller: $reseller)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GatewayItem'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('organizationId', organizationId))
      ..add(DiagnosticsProperty('networkServerId', networkServerId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('firstSeenAt', firstSeenAt))
      ..add(DiagnosticsProperty('lastSeenAt', lastSeenAt))
      ..add(DiagnosticsProperty('model', model))
      ..add(DiagnosticsProperty('osversion', osversion))
      ..add(DiagnosticsProperty('health', health))
      ..add(DiagnosticsProperty('uptimeHealth', uptimeHealth))
      ..add(DiagnosticsProperty('miningFuelHealth', miningFuelHealth))
      ..add(DiagnosticsProperty('miningFuel', miningFuel))
      ..add(DiagnosticsProperty('miningFuelMax', miningFuelMax))
      ..add(DiagnosticsProperty('totalMined', totalMined))
      ..add(DiagnosticsProperty('reseller', reseller));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GatewayItem &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.organizationId, organizationId) ||
                const DeepCollectionEquality()
                    .equals(other.organizationId, organizationId)) &&
            (identical(other.networkServerId, networkServerId) ||
                const DeepCollectionEquality()
                    .equals(other.networkServerId, networkServerId)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.firstSeenAt, firstSeenAt) ||
                const DeepCollectionEquality()
                    .equals(other.firstSeenAt, firstSeenAt)) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastSeenAt, lastSeenAt)) &&
            (identical(other.model, model) ||
                const DeepCollectionEquality().equals(other.model, model)) &&
            (identical(other.osversion, osversion) ||
                const DeepCollectionEquality()
                    .equals(other.osversion, osversion)) &&
            (identical(other.health, health) ||
                const DeepCollectionEquality().equals(other.health, health)) &&
            (identical(other.uptimeHealth, uptimeHealth) ||
                const DeepCollectionEquality()
                    .equals(other.uptimeHealth, uptimeHealth)) &&
            (identical(other.miningFuelHealth, miningFuelHealth) ||
                const DeepCollectionEquality()
                    .equals(other.miningFuelHealth, miningFuelHealth)) &&
            (identical(other.miningFuel, miningFuel) ||
                const DeepCollectionEquality()
                    .equals(other.miningFuel, miningFuel)) &&
            (identical(other.miningFuelMax, miningFuelMax) ||
                const DeepCollectionEquality()
                    .equals(other.miningFuelMax, miningFuelMax)) &&
            (identical(other.totalMined, totalMined) ||
                const DeepCollectionEquality()
                    .equals(other.totalMined, totalMined)) &&
            (identical(other.reseller, reseller) ||
                const DeepCollectionEquality()
                    .equals(other.reseller, reseller)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(organizationId) ^
      const DeepCollectionEquality().hash(networkServerId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(firstSeenAt) ^
      const DeepCollectionEquality().hash(lastSeenAt) ^
      const DeepCollectionEquality().hash(model) ^
      const DeepCollectionEquality().hash(osversion) ^
      const DeepCollectionEquality().hash(health) ^
      const DeepCollectionEquality().hash(uptimeHealth) ^
      const DeepCollectionEquality().hash(miningFuelHealth) ^
      const DeepCollectionEquality().hash(miningFuel) ^
      const DeepCollectionEquality().hash(miningFuelMax) ^
      const DeepCollectionEquality().hash(totalMined) ^
      const DeepCollectionEquality().hash(reseller);

  @JsonKey(ignore: true)
  @override
  _$GatewayItemCopyWith<_GatewayItem> get copyWith =>
      __$GatewayItemCopyWithImpl<_GatewayItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GatewayItemToJson(this);
  }
}

abstract class _GatewayItem implements GatewayItem {
  factory _GatewayItem(
      {@required
          String id,
      @required
          String name,
      @required
          String description,
      @required
          Map<dynamic, dynamic> location,
      @required
      @JsonKey(name: 'organizationID')
          String organizationId,
      @required
      @JsonKey(name: 'networkServerID')
          String networkServerId,
      @required
          String createdAt,
      @nullable
          String updatedAt,
      @nullable
          String firstSeenAt,
      @nullable
          String lastSeenAt,
      @nullable
          String model,
      @nullable
          String osversion,
      @nullable
          double health,
      @nullable
          double uptimeHealth,
      @nullable
          double miningFuelHealth,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuel,
      @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
      @nullable
          Decimal miningFuelMax,
      @nullable
          double totalMined,
      bool reseller}) = _$_GatewayItem;

  factory _GatewayItem.fromJson(Map<String, dynamic> json) =
      _$_GatewayItem.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  Map<dynamic, dynamic> get location;
  @override // RETHINK.TODO - remove map
  @JsonKey(name: 'organizationID')
  String get organizationId;
  @override
  @JsonKey(name: 'networkServerID')
  String get networkServerId;
  @override
  String get createdAt;
  @override
  @nullable
  String get updatedAt;
  @override
  @nullable
  String get firstSeenAt;
  @override
  @nullable
  String get lastSeenAt;
  @override
  @nullable
  String get model;
  @override
  @nullable
  String get osversion;
  @override
  @nullable
  double get health;
  @override
  @nullable
  double get uptimeHealth;
  @override
  @nullable
  double get miningFuelHealth;
  @override
  @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
  @nullable
  Decimal get miningFuel;
  @override
  @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
  @nullable
  Decimal get miningFuelMax;
  @override
  @nullable
  double get totalMined;
  @override
  bool get reseller;
  @override
  @JsonKey(ignore: true)
  _$GatewayItemCopyWith<_GatewayItem> get copyWith;
}
