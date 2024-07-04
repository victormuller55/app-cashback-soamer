import 'package:flutter/material.dart';

class AppContext {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext context = AppContext.navigatorKey.currentContext!;
}