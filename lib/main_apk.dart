import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:flutter_appcenter/flutter_appcenter_apk.dart';

import 'main_common.dart';

void main() async {
  Updater.init(ApkUpdateHandler(
      'https://datadash.oss-accelerate.aliyuncs.com/app-prod-release.apk'));
  await commonMain();
}
