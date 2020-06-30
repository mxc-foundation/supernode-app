import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'introduction_component/component.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DeviceMapBoxPage extends Page<DeviceMapBoxState, Map<String, dynamic>> {
  DeviceMapBoxPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DeviceMapBoxState>(
                adapter: null,
                slots: <String, Dependent<DeviceMapBoxState>>{
                  'introduction':IntroductionConnector()+IntroductionComponent()
                }),
            middleware: <Middleware<DeviceMapBoxState>>[
            ],);

}
