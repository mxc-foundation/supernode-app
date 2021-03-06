import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';

class JoinCouncilState implements Cloneable<JoinCouncilState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isDemo;
  bool resSuccess;

  String amount;
  double boostRate;
  double avgDailyDhxRevenue;
  int months;
  int minersOwned;

  List<Council> councils;

  @override
  JoinCouncilState clone() {
    return JoinCouncilState()
      ..scaffoldKey = scaffoldKey
      ..isDemo = isDemo
      ..resSuccess = resSuccess
      ..amount = amount
      ..boostRate = boostRate
      ..months = months
      ..minersOwned = minersOwned
      ..councils = councils
      ..avgDailyDhxRevenue = avgDailyDhxRevenue;
  }
}

JoinCouncilState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;

  String amount = args['amount'] ?? (throw ArgumentError.notNull('amount'));
  int months = args['months'] ?? (throw ArgumentError.notNull('months'));
  double boostRate =
      args['boostRate'] ?? (throw ArgumentError.notNull('boostRate'));

  int minersOwned =
      args['minersOwned'] ?? (throw ArgumentError.notNull('minersOwned'));

  double avgDailyDhxRevenue = args['avgDailyDhxRevenue'];

  return JoinCouncilState()
    ..isDemo = isDemo
    ..amount = amount
    ..months = months
    ..minersOwned = minersOwned
    ..boostRate = boostRate
    ..avgDailyDhxRevenue = avgDailyDhxRevenue;
}
