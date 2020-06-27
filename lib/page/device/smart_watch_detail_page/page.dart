import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SmartWatchDetailPage extends Page<SmartWatchDetailState, Map<String, dynamic>> {
  SmartWatchDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SmartWatchDetailState>(
                adapter: null,
                slots: <String, Dependent<SmartWatchDetailState>>{
                }),
            middleware: <Middleware<SmartWatchDetailState>>[
            ],);

}
