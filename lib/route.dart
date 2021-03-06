import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

/// Route with Firebase analytics
MaterialPageRoute routeWidget(Widget page) {
  try {
    analytics.setCurrentScreen(screenName: page.runtimeType.toString());
  } catch (e) {}
  return MaterialPageRoute(builder: (_) => page);
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
final FirebaseAnalytics analytics = FirebaseAnalytics();
