import 'package:dotenv/dotenv.dart' show env, load;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'add_miner_test.dart' show addMinerTest;
import 'delete_miner_test.dart' show deleteMinerTest;
import 'help_bubble_test.dart' show helpBubbleTest;
import 'login_test.dart' show loginPageTests;
import 'logout_test.dart' show logoutTest;
import 'stake_test.dart' show stakingTest;
import 'homepage_api_test.dart' show homeAPITest;
import 'miner_list_api_test.dart' show minerListAPITest;
import 'miner_details_test.dart' show minerDetailsAPITest;
import 'supernodes.dart' show s;

void main() {
  load();
  group('Supernode App', () {
    FlutterDriver driver;

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });
    load();
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    if (env['ENVIRONMENT'] == 'test') {
      loginPageTests('MXCtest', env['DRIVE_MXCTEST_PASSWORD']);
      homeAPITest();
      stakingTest(env['DRIVE_MXCTEST_OTP_KEY']);
      helpBubbleTest();
      addMinerTest();
      minerListAPITest();
      minerDetailsAPITest();
      deleteMinerTest();
      logoutTest('MXCtest');
    } else
      for (var i = 0; i < s.length; i++) {
        loginPageTests(s[i][0], s[i][1]);
        homeAPITest();
        stakingTest(s[i][2]);
        helpBubbleTest();
        addMinerTest();
        minerListAPITest();
        minerDetailsAPITest();
        deleteMinerTest();
        logoutTest(s[i][0]);
      }
  });
}
