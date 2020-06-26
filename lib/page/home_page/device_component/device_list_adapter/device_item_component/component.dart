import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DeviceItemComponent extends Component<DeviceItemState> {
  DeviceItemComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DeviceItemState>(
                adapter: null,
                slots: <String, Dependent<DeviceItemState>>{
                }),);

}
