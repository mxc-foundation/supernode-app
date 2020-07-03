import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DiscoveryBorderComponent extends Component<DiscoveryBorderState> {
  DiscoveryBorderComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DiscoveryBorderState>(
                adapter: null,
                slots: <String, Dependent<DiscoveryBorderState>>{
                }),);

}
