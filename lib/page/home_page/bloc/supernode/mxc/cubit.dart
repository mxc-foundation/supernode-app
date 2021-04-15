import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';

import 'state.dart';

class SupernodeMxcCubit extends Cubit<SupernodeMxcState> {
  SupernodeMxcCubit({
    @required this.cacheRepository,
    @required this.supernodeRepository,
    @required this.orgId,
    @required this.homeCubit,
  }) : super(SupernodeMxcState());

  final CacheRepository cacheRepository;
  final SupernodeRepository supernodeRepository;
  final String orgId;
  final HomeCubit homeCubit;

  Future<void> initState() async {
    await refresh();
  }

  Future<void> refresh() async {
    await Future.wait([
      refreshStakes(),
      refreshTopups(),
      refreshWithdraws(),
    ]);
  }

  Future<void> refreshStakes() async {
    emit(state.copyWith(stakes: state.stakes.withLoading()));
    try {
      var history = await supernodeRepository.stake.history(
        orgId: orgId,
        currency: '',
        from: DateTime(2000).toUtc(),
        till: DateTime.now().toUtc().add(
              Duration(days: 1),
            ),
      );
      emit(state.copyWith(stakes: Wrap(history)));
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(stakes: state.stakes.withError(e)));
    }
  }

  Future<void> refreshTopups() async {
    emit(state.copyWith(topups: state.topups.withLoading()));
    try {
      final data = {
        'orgId': orgId,
        'from': DateTime(2000).toUtc().toIso8601String(),
        'till': DateTime.now().toUtc().add(Duration(days: 1)).toIso8601String(),
        'currency': '',
      };
      var history = await supernodeRepository.topup.history(data);
      emit(state.copyWith(topups: Wrap(history)));
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(topups: state.topups.withError(e)));
    }
  }

  Future<void> refreshWithdraws() async {
    emit(state.copyWith(withdraws: state.withdraws.withLoading()));
    try {
      final data = {
        'orgId': orgId,
        'from': DateTime(2000).toUtc().toIso8601String(),
        'till': DateTime.now().toUtc().add(Duration(days: 1)).toIso8601String(),
        'currency': '',
      };
      var history = await supernodeRepository.withdraw.history(data);
      emit(state.copyWith(withdraws: Wrap(history)));
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(withdraws: state.withdraws.withError(e)));
    }
  }
}
