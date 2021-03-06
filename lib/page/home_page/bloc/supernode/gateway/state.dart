import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
abstract class GatewayState with _$GatewayState {
  factory GatewayState({
    @Default(Wrap.pending()) Wrap<int> gatewaysTotal,
    @Default(Wrap.pending()) Wrap<List<GatewayItem>> gateways,
    List<MinerHealthResponse> listMinersHealth,
    @Default(Wrap.pending()) Wrap<double> health,
    @Default(Wrap.pending()) Wrap<double> uptimeHealth,
    @Default(Wrap.pending()) Wrap<double> miningFuelHealth,
    @Default(Wrap.pending()) Wrap<double> miningFuel,
    @Default(Wrap.pending()) Wrap<double> miningFuelMax,
    GatewayItem selectedGateway,
    double downlinkPrice,
    List<GatewayStatisticResponse> framesLast7days,
    List<DailyStatistic> statsLast7days,
    double sumMiningRevenueLast7days,
    @Default(0) int sumSecondsOnlineLast7days,
    @Default(1) int secondsLast7days,
  }) = _GatewayState;
}

@freezed
abstract class GatewayItem with _$GatewayItem {
  factory GatewayItem({
    @required String id,
    @required String name,
    @required String description,
    @required Map location, // RETHINK.TODO - remove map
    @required @JsonKey(name: 'organizationID') String organizationId,
    @required @JsonKey(name: 'networkServerID') String networkServerId,
    @required String createdAt,
    @nullable String updatedAt,
    @nullable String firstSeenAt,
    @nullable String lastSeenAt,
    @nullable String model,
    @nullable String osversion,
    @nullable double health,
    @nullable double uptimeHealth,
    @nullable double miningFuelHealth,
    @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
    @nullable
        Decimal miningFuel,
    @JsonKey(fromJson: Decimal.tryParse, toJson: _decimalToJson)
    @nullable
        Decimal miningFuelMax,
    @nullable double totalMined,
    @Default(false) bool reseller,
  }) = _GatewayItem;

  factory GatewayItem.fromJson(Map<String, dynamic> json) =>
      _$GatewayItemFromJson(json);
}

String _decimalToJson(s) => s.toString();
