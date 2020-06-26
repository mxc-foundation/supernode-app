import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChooseApplicationPage extends Page<ChooseApplicationState, Map<String, dynamic>> {
  ChooseApplicationPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChooseApplicationState>(
                adapter: null,
                slots: <String, Dependent<ChooseApplicationState>>{
                }),
            middleware: <Middleware<ChooseApplicationState>>[
            ],);

}
