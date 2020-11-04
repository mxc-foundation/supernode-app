import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'utils.dart' show delay, isPresent;
import 'finders.dart' show f;

deleteMinerTest() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('delete miner', () async {
    await driver.waitFor(f['minersNewMiner']);
    await driver.scroll(f['minersNewMiner'], -100, 0, Duration(seconds: 1));
    print('SWIPE GATEWAY TO REVEAL DELETE');
    await driver.waitFor(f['minerDeleteButton']);
    await driver.tap(f['minerDeleteButton']);
    print('TAP DELETE BUTTON');
    await driver.waitFor(f['minerConfirmDeleteButton']);
    await driver.tap(f['minerConfirmDeleteButton']);
    print('CONFIRM DELETE');
    delay(5000);
    var MinerExists = await isPresent(f['minersNewMiner'], driver);
    expect(await MinerExists, false);
  }, timeout:Timeout(Duration(seconds: 60)));
}