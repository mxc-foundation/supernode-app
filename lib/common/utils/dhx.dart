import 'dart:math';

import 'package:flutter/foundation.dart';

const double boost3months = 0.0;
const double boost9months = 0.1;
const double boost12months = 0.2;
const double boost24months = 0.4;
List<int> get monthsOptions => [3, 9, 12, 24];

double monthsToBoost(int months) {
  switch (months) {
    case 3:
      return boost3months;
    case 9:
      return boost9months;
    case 12:
      return boost12months;
    case 24:
      return boost24months;
    default:
      return null;
  }
}

double getMinersBoost(double mxcValue, int minersCount) {
  return min(mxcValue, minersCount * 1000000.0);
}

double calculateDhxDaily({
  @required double mxcLocked,
  @required int minersCount,
  @required double yesterdayTotalDHX,
  @required double yesterdayTotalMPower,
  @required int months,
}) {
  final mPower = mxcLocked == null || minersCount == null
      ? null
      : calculateMiningPower(mxcLocked, minersCount, monthsToBoost(months));

  return mPower == null ||
          yesterdayTotalDHX == null ||
          yesterdayTotalMPower == null
      ? null
      : mPower * (yesterdayTotalDHX / yesterdayTotalMPower);
}

double calculateMiningPower(
    double mxcValue, int minersCount, double monthsBoostRate) {
  var miningPower = mxcValue + mxcValue * monthsBoostRate;
  miningPower = miningPower + getMinersBoost(miningPower, minersCount);
  return miningPower;
}
