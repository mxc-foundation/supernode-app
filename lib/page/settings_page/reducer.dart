import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/global_store/store.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingsState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingsState>>{
      SettingsAction.notification: _notification,
    },
  );
}

SettingsState _notification(SettingsState state, Action action) {
  bool toogle = action.payload;

  SettingsState settingsData = GlobalStore.store.getState().settings;
  settingsData.notification = toogle;

  SettingsDao.updateLocal(settingsData);

  final SettingsState newState = state.clone();
  return newState
    ..notification = toogle;
}