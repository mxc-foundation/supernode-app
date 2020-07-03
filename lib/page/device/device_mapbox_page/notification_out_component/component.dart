import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NotificationOutComponent extends Component<NotificationOutState> {
  NotificationOutComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NotificationOutState>(
                adapter: null,
                slots: <String, Dependent<NotificationOutState>>{
                }),);

}
