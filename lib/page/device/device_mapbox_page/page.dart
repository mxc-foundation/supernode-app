import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/border_prompt_component/component.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/discover_component/component.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/discovery_border_component/component.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/footprints_component/component.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/footprints_location_component/component.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/notification_component/component.dart';
import 'package:supernodeapp/page/device/device_mapbox_page/notification_out_component/component.dart';

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
                'introduction':
                    IntroductionConnector() + IntroductionComponent(),
                'discover': DiscoverConnector() + DiscoverComponent(),
                'footprints': FootprintsConnector() + FootprintsComponent(),
                'notification':
                    NotificationConnector() + NotificationComponent(),
                'discoverBorder':
                    DiscoverBorderConnector() + DiscoveryBorderComponent(),
                'footPrintsLocation': FootPrintsLocationConnector() +
                    FootPrintsLocationComponent(),
                'notificationOut':
                    NotificationOutConnector() + NotificationOutComponent(),
                'borderPrompt':
                    BorderPromptConnector() + BorderPromptComponent(),
              }),
          middleware: <Middleware<DeviceMapBoxState>>[],
        );
}
