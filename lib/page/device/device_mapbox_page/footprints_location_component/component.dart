import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FootPrintsLocationComponent extends Component<FootPrintsLocationState> {
  FootPrintsLocationComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FootPrintsLocationState>(
                adapter: null,
                slots: <String, Dependent<FootPrintsLocationState>>{
                }),);

}
