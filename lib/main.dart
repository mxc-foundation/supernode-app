import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:flutter_appcenter/flutter_appcenter_gp.dart';

import 'main_common.dart';

void main() async {
  Updater.init(GooglePlayUpdateHandler());
  await commonMain();
}
