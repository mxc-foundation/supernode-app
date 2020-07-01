import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NotificationComponent extends Component<NotificationState> {
  NotificationComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NotificationState>(
                adapter: null,
                slots: <String, Dependent<NotificationState>>{
                }),);

}
