import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
part 'app_state.freezed.dart';

enum ThemeOption { dark, light, system }

@freezed
abstract class AppState with _$AppState {
  factory AppState({
    Locale locale,
    @nullable FiatCurrency selectedFiatForExport,
    @Default(false) bool isDemo,
    @Default(false) bool showLoading,
    @Default(ThemeOption.system) ThemeOption theme,
    @nullable ErrorInfo error,
    @nullable SuccessInfo success,
  }) = _AppState;
}

@freezed
abstract class SupernodeState with _$SupernodeState {
  SupernodeState._();
  factory SupernodeState({
    SupernodeSession session,
    Supernode selectedNode,
    String orgId,
  }) = _SupernodeState;
}

@freezed
abstract class SupernodeSession with _$SupernodeSession {
  factory SupernodeSession({
    int userId,
    String username,
    String token,
    DateTime expire,
    String password,
    Supernode node,
    @Default(false) bool tfaEnabled,
  }) = _SupernodeSession;
}

@freezed
abstract class DataHighwayState with _$DataHighwayState {
  DataHighwayState._();
  factory DataHighwayState({
    DataHighwaySession session,
  }) = _DataHighwayState;
}

@freezed
abstract class DataHighwaySession with _$DataHighwaySession {
  DataHighwaySession._();
  factory DataHighwaySession({
    String address,
  }) = _DataHighwaySession;
}

class ErrorInfo {
  final String text;

  ErrorInfo(this.text);
}

class SuccessInfo {
  final String text;

  SuccessInfo(this.text);
}
