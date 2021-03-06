import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppPage extends StatefulWidget {
  final Widget child;

  AppPage({Key key, this.child}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      // RETHINK.TODO
      // case AppLifecycleState.resumed:
      //   Dao.dio.unlock();
      //   break;
      // case AppLifecycleState.paused:
      //   Dao.dio.lock();
      //   break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
