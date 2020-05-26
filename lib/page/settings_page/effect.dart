import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supernodeapp/common/daos/settings_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'action.dart';
import 'state.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future onSelectNotification(String payload) async {
  // print(payload);
}

Future onDidReceiveLocalNotification(
  int id, String title, String body, String payload) async {
  // print(title);
}

Effect<SettingsState> buildEffect() {
  return combineEffects(<Object, Effect<SettingsState>>{
    Lifecycle.dispose: _onDispose,
    SettingsAction.onSettings: _onSettings,
  });
}

void _onSettings(Action action, Context<SettingsState> ctx) async{
  String page = action.payload;

  if(page == 'logout'){
    SettingsState settingsData = GlobalStore.store.getState().settings;
    settingsData.userId = '';
    settingsData.selectedOrganizationId = '';
    settingsData.organizations = [];
    settingsData.language = '';

    SettingsDao.updateLocal(settingsData);

    Locale locale = Localizations.localeOf(ctx.context);
    await FlutterI18n.refresh(ctx.context, locale);

    Navigator.of(ctx.context).pushNamedAndRemoveUntil('login_page',(_) => false);

    return;
  }

  if(page == 'notification'){
    try{
      _noticationEnable();
      ctx.state.notification = !ctx.state.notification;
    }catch(e){
      ctx.state.notification = false;
    }

    ctx.dispatch(SettingsActionCreator.notification(ctx.state.notification));
    return;
  }

  Navigator.push(ctx.context,
    MaterialPageRoute(
      maintainState: false,
      fullscreenDialog: true,
      builder:(context){
        return ctx.buildComponent(page);
      }
    ),
  );

}

void _noticationEnable(){
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
  new AndroidInitializationSettings('app_icon');

  var initializationSettingsIOS = 
  IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  var initializationSettings = InitializationSettings(initializationSettingsAndroid,initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
}

void _onDispose(Action action, Context<SettingsState> ctx) async{
  // await flutterLocalNotificationsPlugin.cancel(0);
  // await flutterLocalNotificationsPlugin.cancelAll();
}