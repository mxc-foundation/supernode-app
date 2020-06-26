import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/device_component/device_list_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DeviceComponent extends Component<DeviceState> {
  DeviceComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DeviceState>(
              adapter: NoneConn<DeviceState>() + DeviceListAdapter(),
              slots: <String, Dependent<DeviceState>>{}),
        );
}
