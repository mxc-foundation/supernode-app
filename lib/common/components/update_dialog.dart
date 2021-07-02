import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_appcenter/flutter_appcenter.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class Updater {
  final UpdateHandler handler;

  static Updater _instance;
  static Updater get instance => _instance;

  Updater._(this.handler);

  static void init(UpdateHandler updateHandler) {
    _instance = Updater._(updateHandler);
  }

  Future<bool> updateDialog(BuildContext ctx) {
    return FlutterAppCenter.checkForUpdate(ctx, handler, dialog: {
      'title': FlutterI18n.translate(ctx, 'update_dialog_title'),
      'subTitle': FlutterI18n.translate(ctx, 'update_dialog_subTitle'),
      'content': FlutterI18n.translate(ctx, 'update_dialog_content'),
      'confirmButtonText': Platform.isAndroid
          ? FlutterI18n.translate(ctx, 'update_dialog_confirm')
          : 'App Store',
      'middleButtonText': Platform.isAndroid ? '' : 'TestFlight',
      'cancelButtonText': FlutterI18n.translate(ctx, 'update_dialog_cancel'),
      'downloadingText': FlutterI18n.translate(ctx, 'update_dialog_downloading')
    });
  }
}
