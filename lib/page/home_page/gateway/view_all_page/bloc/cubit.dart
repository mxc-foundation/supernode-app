import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/miner.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/utils/tools.dart';

import 'state.dart';

class MinerStatsCubit extends Cubit<MinerStatsState> {
  MinerStatsCubit(
    this.appCubit,
    this.supernodeCubit,
    this.supernodeRepository,
    this.weekLabels,
    this.monthsAbbLabels,
    this.monthsLabels,
  ) : super(MinerStatsState());

  final AppCubit appCubit;
  final SupernodeCubit supernodeCubit;
  final SupernodeRepository supernodeRepository;
  final Map<int, String> weekLabels;
  final Map<int, String> monthsAbbLabels;
  final Map<int, String> monthsLabels;

  String getMD(DateTime date) {
    return '${monthsLabels[date.month]} ${date.day}';
  }

  String getMDY(DateTime date) {
    return '${monthsLabels[date.month]} ${date.day} ${date.year}';
  }

  void tabTime(String time) {
    MinerStatsTime selectedTime = MinerStatsTime.week;

    if (time == 'week') {
      selectedTime = MinerStatsTime.week;
    } else if (time == 'month') {
      selectedTime = MinerStatsTime.month;
    } else {
      selectedTime = MinerStatsTime.year;
    }

    emit(state.copyWith(selectedTime: selectedTime));
    emit(state.copyWith(scrollFirstIndex: 0));
    emit(state.copyWith(originList: []));
    emit(state.copyWith(originMonthlyList: []));
    emit(state.copyWith(originYearlyList: []));
  }

  void setSelectedType(MinerStatsType type) {
    emit(state.copyWith(selectedType: type));
  }

  int getNumBar() {
    MinerStatsTime time = state.selectedTime;

    if (time == MinerStatsTime.week) {
      return 7;
    } else if (time == MinerStatsTime.month) {
      return 5;
    } else {
      return 12;
    }
  }

  String getTooltip(MinerStatsEntity item) {
    String label = '';
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      label = '${Tools.priceFormat(item.uptime / 3600, range: 0)} h';
    } else if (type == MinerStatsType.revenue) {
      label = '${Tools.priceFormat(item.revenue)} MXC';
    } else if (type == MinerStatsType.frameReceived) {
      label = '${Tools.priceFormat(item.received)}';
    } else {
      label = '${Tools.priceFormat(item.transmitted)}';
    }

    return label;
  }

  List<MinerStatsEntity> getStatsData() {
    List<MinerStatsEntity> list = getOriginTypeList();

    if (list.isEmpty) return [];

    int lastIndex = state.scrollFirstIndex + getNumBar();

    if (lastIndex < list.length) {
      return list.sublist(state.scrollFirstIndex, lastIndex);
    } else {
      return list.sublist(list.length - 10, list.length);
    }
  }

  String getStatsTitle() {
    List titles = [];
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      titles = ['score_weekly_total', 'total_hours', 'total_hours'];
    } else if (type == MinerStatsType.revenue) {
      titles = ['weekly_amount', 'monthly_amount', 'yearly_amount'];
    } else {
      titles = ['weekly_packet', 'monthly_packet', 'yearly_packet'];
    }

    return titles[state.selectedTime?.index ?? 0];
  }

  String getStatsSubitle(BuildContext context) {
    MinerStatsType type = state.selectedType;

    if (type == MinerStatsType.uptime) {
      return '${getUptimeWeekScore()} h';
    } else if (type == MinerStatsType.revenue) {
      return '${countTotal().toStringAsFixed(0)} MXC ${getRevenueWeekScore(context)}';
    } else if (type == MinerStatsType.frameReceived) {
      return '${countTotal().toStringAsFixed(0)}';
    } else {
      return '${countTotal().toStringAsFixed(0)}';
    }
  }

  String getUptimeWeekScore() {
    MinerStatsTime time = state.selectedTime;

    if (time == MinerStatsTime.week) {
      if (state.originList.isEmpty) return '0';

      List<MinerStatsEntity> newData = getStatsData();

      DateTime today = DateTime.now();
      double totalWeekScore = 24.0 * 3600 * newData.length;

      MinerStatsEntity hasTodayItem;

      if (newData.any((item) => TimeUtil.isSameDay(item.date, today))) {
        hasTodayItem =
            newData.firstWhere((item) => TimeUtil.isSameDay(item.date, today));
      }

      if (hasTodayItem != null) {
        totalWeekScore =
            24.0 * 3600 * (newData.length - 1) + (hasTodayItem.uptime);
      }

      double totalScore = newData.fold(
              0, (previousValue, item) => previousValue + item.uptime) /
          totalWeekScore *
          100;

      return '(${totalScore.toStringAsFixed(0)}%) ${countTotal().toStringAsFixed(0)}';
    }

    return '${countTotal().toStringAsFixed(0)}';
  }

  String getRevenueWeekScore(BuildContext context) {
    MinerStatsTime time = state.selectedTime;

    if (time == MinerStatsTime.week) {
      return '(${(countTotal() / getStatsData().length).toStringAsFixed(0)}/${FlutterI18n.translate(context, "day")})';
    }

    return '';
  }

  double countTotal() {
    double total = 0;
    MinerStatsType type = state.selectedType;

    List<MinerStatsEntity> newData = getStatsData();

    if (type == MinerStatsType.uptime) {
      total = newData.fold(
              0, (previousValue, item) => previousValue + item.uptime) /
          3600;
    } else if (type == MinerStatsType.revenue) {
      total = newData.fold(
          0, (previousValue, item) => previousValue + item.revenue);
    } else if (type == MinerStatsType.frameReceived) {
      total = newData.fold(
          0, (previousValue, item) => previousValue + item.received);
    } else {
      total = newData.fold(
          0, (previousValue, item) => previousValue + item.transmitted);
    }

    return total;
  }

  void setScrollFirstIndex(int index) {
    emit(state.copyWith(scrollFirstIndex: index));
  }

  String getStartTimeLabel() {
    MinerStatsTime time = state.selectedTime;
    List<MinerStatsEntity> newData = getStatsData();

    if (newData.isEmpty) return '';

    if (time == MinerStatsTime.week) {
      return getMD(newData.last.date);
    } else if (time == MinerStatsTime.month) {
      return getMD(newData.last.date);
    } else {
      return getMDY(newData.last.date);
    }
  }

  String getEndTimeLabel() {
    MinerStatsTime time = state.selectedTime;
    List<MinerStatsEntity> newData = getStatsData();

    if (newData.isEmpty) return '';

    if (time == MinerStatsTime.week) {
      return getMD(newData.first.date);
    } else if (time == MinerStatsTime.month) {
      return getMD(newData.first.date);
    } else {
      return getMDY(newData.first.date);
    }
  }

  Future<void> dispatchData(
      {MinerStatsType type = MinerStatsType.uptime,
      MinerStatsTime time = MinerStatsTime.week,
      DateTime startTime,
      String minerId}) async {
    switch (type) {
      case MinerStatsType.uptime:
      case MinerStatsType.revenue:
        getStatsMinerData(type, time, startTime, minerId);
        break;
      case MinerStatsType.frameReceived:
      case MinerStatsType.frameTransmitted:
        getStatsFrameData(type, time, startTime, minerId);
        break;
      default:
        break;
    }
  }

  DateTime getStartTime(MinerStatsTime time, DateTime startTime) {
    if (time == MinerStatsTime.week) {
      return startTime?.add(Duration(days: -12)) ??
          DateTime.now().add(Duration(days: -12));
    } else if (time == MinerStatsTime.month) {
      return startTime?.add(Duration(days: -60)) ??
          DateTime.now().add(Duration(days: -60));
    } else {
      return startTime?.add(Duration(days: -(365 * 2))) ??
          DateTime.now().add(Duration(days: -(365 * 2)));
    }
  }

  DateTime getEndTime(MinerStatsTime time, DateTime endTime) {
    if (time == MinerStatsTime.week) {
      endTime = endTime?.add(Duration(days: -1)) ?? DateTime.now();
    } else if (time == MinerStatsTime.month) {
      endTime = endTime?.add(Duration(days: -30)) ?? DateTime.now();
    } else {
      endTime = endTime?.add(Duration(days: -365)) ?? DateTime.now();
    }

    return endTime;
  }

  Future<void> getStatsMinerData(MinerStatsType type, MinerStatsTime time,
      DateTime startTime, String minerId) async {
    await getSourceMinerData(
      gatewayMac: minerId,
      orgId: supernodeCubit.state.orgId,
      startTime: getStartTime(time, startTime),
      endTime: getEndTime(time, startTime),
      successCB: (result) {
        generateChartData(type, time, result);
      },
    );
  }

  Future<void> getStatsFrameData(MinerStatsType type, MinerStatsTime time,
      DateTime startTime, String minerId) async {
    await getSourceFrameData(
      gatewayId: minerId,
      interval: 'DAY',
      startTime: getStartTime(time, startTime),
      endTime: getEndTime(time, startTime),
      successCB: (result) {
        generateChartData(type, time, result);
      },
    );
  }

  List<MinerStatsEntity> generateMinerEntities(
      DateTime startTime, DateTime endTime) {
    List<MinerStatsEntity> dates = [];
    int totalDays = endTime.difference(startTime).inDays;

    for (int i = 0; i <= totalDays; i++) {
      dates.add(MinerStatsEntity(
          date: startTime.add(Duration(days: i)),
          uptime: 0,
          revenue: 0,
          health: 0,
          received: 0,
          transmitted: 0));
    }

    return dates;
  }

  Future<void> getSourceMinerData({
    String gatewayMac,
    String orgId,
    DateTime startTime,
    DateTime endTime,
    Function successCB,
  }) async {
    List<MinerStatsEntity> entities = generateMinerEntities(startTime, endTime);

    try {
      var result = await supernodeRepository.wallet.miningIncomeGateway(
        gatewayMac: gatewayMac,
        orgId: orgId,
        fromDate: DateTime.utc(startTime.year, startTime.month, startTime.day),
        tillDate: DateTime.utc(endTime.year, endTime.month, endTime.day),
      );

      if (successCB != null) {
        if (double.tryParse(result.total) > 0) {
          entities = entities.map((entity) {
            result.dailyStats.forEach((item) {
              var currentEntity = MinerStatsEntity(
                date: item.date,
                health: item.health,
                received: 0,
                transmitted: 0,
                revenue: double.tryParse(item.amount ?? '0'),
                uptime: item.onlineSeconds.toDouble(),
              );

              if (currentEntity.date.year == entity.date.year &&
                  currentEntity.date.month == entity.date.month &&
                  currentEntity.date.day == entity.date.day) {
                entity = currentEntity;
                return;
              }
            });

            return entity;
          }).toList();
        }
        successCB(entities);
      }
    } catch (err) {
      appCubit.setError(err.toString());
    }
  }

  Future<void> getSourceFrameData({
    DateTime startTime,
    DateTime endTime,
    Function successCB,
    String gatewayId,
    String interval,
  }) async {
    List<MinerStatsEntity> entities = generateMinerEntities(startTime, endTime);

    try {
      var result = await supernodeRepository.gateways.frames(
        gatewayId,
        interval: interval,
        startTimestamp: startTime,
        endTimestamp: endTime,
      );

      if (successCB != null) {
        if (result.length > 0) {
          entities = entities.map((entity) {
            result.forEach((item) {
              var currentEntity = MinerStatsEntity(
                date: item.timestamp,
                health: 0,
                transmitted: item.txPacketsEmitted.toDouble(),
                received: item.rxPacketsReceivedOK.toDouble(),
                revenue: 0,
                uptime: 0,
              );

              if (currentEntity.date.year == entity.date.year &&
                  currentEntity.date.month == entity.date.month &&
                  currentEntity.date.day == entity.date.day) {
                entity = currentEntity;
                return;
              }
            });

            return entity;
          }).toList();
        }
        successCB(entities);
      }
    } catch (err) {
      appCubit.setError(err.toString());
    }
  }

  int getYAxisStep(double maxValue) {
    int step = 3;

    if (maxValue >= 20000) {
      step = 2000;
    } else if (maxValue >= 6400) {
      step = 800;
    } else if (maxValue >= 1600) {
      step = 200;
    } else if (maxValue >= 800) {
      step = 40;
    } else if (maxValue >= 730) {
      step = 91;
    } else if (maxValue >= 240) {
      step = 30;
    } else if (maxValue >= 168) {
      step = 21;
    } else if (maxValue >= 100) {
      step = 10;
    } else if (maxValue >= 24) {
      step = 3;
    }

    return step;
  }

  List<int> getYLabel(double maxValue) {
    List<int> yLabel = [];
    int step = 3;

    if(state.selectedType == MinerStatsType.uptime){
      step = getYAxisStep(maxValue);
    }else{
      step = (maxValue / 10).floor();
    }

    for (int y = step; y <= maxValue; y += step) {
      yLabel.add(y);
    }

    yLabel.sort((a, b) => b.compareTo(a));

    return yLabel;
  }

  List<MinerStatsEntity> getOriginTypeList() {
    MinerStatsTime time = state.selectedTime;
    if (time == MinerStatsTime.week) {
      return state.originList;
    } else if (time == MinerStatsTime.month) {
      return state.originMonthlyList;
    } else {
      return state.originYearlyList;
    }
  }

  List<MinerStatsEntity> appendAndSortOriginList(
      List<MinerStatsEntity> orginalList, List<MinerStatsEntity> data) {
    orginalList.forEach((item) {
      if (!data.any((element) => TimeUtil.isSameDay(element.date, item.date))) {
        data.add(item);
      }
    });

    data.sort((a, b) => b.date.compareTo(a.date));
    return data;
  }

  void generateChartData(
      MinerStatsType type, MinerStatsTime time, List<MinerStatsEntity> data) {
    double maxValue = 0;
    List<double> xData = [];
    List<String> xLabel = [];
    List<String> yLabel = [];
    List<MinerStatsEntity> newData = [];

    data = appendAndSortOriginList(state.originList, data);
    emit(state.copyWith(originList: data));

    if (time == MinerStatsTime.week) {
      maxValue = maxData(type, state.originList);

      data.forEach((item) {
        if (type == MinerStatsType.uptime) {
          maxValue = 24.0 * 3600;
          xData.add(item.uptime / maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue / maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received / maxValue);
        } else {
          xData.add(item.transmitted / maxValue);
        }

        if (TimeUtil.isSameDay(item.date, DateTime.now())) {
          xLabel.add('today');
        } else {
          xLabel.add(weekLabels[item.date.weekday]);
        }
      });
    } else if (time == MinerStatsTime.month) {
      data.forEach((item) {
        bool hasResult = newData.any((hasItem) =>
            hasItem.date.weekday != DateTime.sunday ||
            TimeUtil.isSameDay(hasItem.date,
                item.date.add(Duration(days: 7 - item.date.weekday))));

        if (hasResult) {
          for (int i = 0; i < newData.length; i++) {
            if (TimeUtil.isSameDay(newData[i].date,
                item.date.add(Duration(days: 7 - item.date.weekday)))) {
              if (type == MinerStatsType.uptime) {
                newData[i].uptime += item.uptime;
              } else if (type == MinerStatsType.revenue) {
                newData[i].revenue += item.revenue;
              } else if (type == MinerStatsType.frameReceived) {
                newData[i].received += item.received;
              } else {
                newData[i].transmitted += item.transmitted;
              }
            }
          }
        } else {
          newData.add(MinerStatsEntity(
              date: item.date.add(Duration(days: 7 - item.date.weekday)),
              uptime: item.uptime,
              revenue: item.revenue,
              health: item.health,
              received: item.received,
              transmitted: item.transmitted));
        }
      });

      emit(state.copyWith(
          originMonthlyList:
              appendAndSortOriginList(state.originMonthlyList, newData)));
      maxValue = maxData(type, state.originMonthlyList);

      newData.forEach((item) {
        if (type == MinerStatsType.uptime) {
          maxValue = 168.0 * 3600;
          xData.add(item.uptime / maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue / maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received / maxValue);
        } else {
          xData.add(item.transmitted / maxValue);
        }

        xLabel.add('${monthsAbbLabels[item.date.month]} ${item.date.day}');
      });
    } else {
      data.forEach((item) {
        bool hasResult = newData
            .any((hasItem) => TimeUtil.isSameMonth(hasItem.date, item.date));

        if (hasResult) {
          for (int i = 0; i < newData.length; i++) {
            if (TimeUtil.isSameMonth(newData[i].date, item.date)) {
              if (type == MinerStatsType.uptime) {
                newData[i].uptime += item.uptime;
              } else if (type == MinerStatsType.revenue) {
                newData[i].revenue += item.revenue;
              } else if (type == MinerStatsType.frameReceived) {
                newData[i].received += item.received;
              } else {
                newData[i].transmitted += item.transmitted;
              }
            }
          }
        } else {
          newData.add(MinerStatsEntity(
              date: item.date,
              uptime: item.uptime,
              revenue: item.revenue,
              health: item.health,
              received: item.received,
              transmitted: item.transmitted));
        }
      });

      emit(state.copyWith(
          originYearlyList:
              appendAndSortOriginList(state.originYearlyList, newData)));
      maxValue = maxData(type, state.originYearlyList);

      newData.forEach((item) {
        if (type == MinerStatsType.uptime) {
          maxValue = 730.0 * 3600;
          xData.add(item.uptime / maxValue);
        } else if (type == MinerStatsType.revenue) {
          xData.add(item.revenue / maxValue);
        } else if (type == MinerStatsType.frameReceived) {
          xData.add(item.received / maxValue);
        } else {
          xData.add(item.transmitted / maxValue);
        }

        xLabel.add(TimeUtil.getM(item.date));
      });
    }

    if (type == MinerStatsType.uptime) {
      maxValue = maxValue / 3600;
    }

    emit(state.copyWith(xDataList: xData));
    emit(state.copyWith(xLabelList: xLabel));
    emit(state.copyWith(yLabelList: getYLabel(maxValue)));
  }

  double maxData(MinerStatsType type, List<MinerStatsEntity> data) {
    double maxValue = 10;
    double tempValue = 0;

    if (data.isEmpty) {
      return maxValue;
    }

    for (int i = 0; i < data.length; i++) {
      for (int j = i + 1; j < data.length; j++) {
        if (type == MinerStatsType.uptime) {
          tempValue = data[i].uptime >= data[j].uptime
              ? data[i].uptime
              : data[j].uptime;
        } else if (type == MinerStatsType.revenue) {
          tempValue = data[i].revenue >= data[j].revenue
              ? data[i].revenue
              : data[j].revenue;
        } else if (type == MinerStatsType.frameReceived) {
          tempValue = data[i].received >= data[j].received
              ? data[i].received
              : data[j].received;
        } else {
          tempValue = data[i].transmitted >= data[j].transmitted
              ? data[i].transmitted
              : data[j].transmitted;
        }

        if (tempValue > maxValue) {
          maxValue = tempValue;
        }
      }
    }

    maxValue += (10 - (maxValue % 10));

    return maxValue;
  }
}
