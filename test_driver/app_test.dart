import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;


Future<void> delay([int milliseconds = 250]) async {
  await Future<void>.delayed(Duration(milliseconds: milliseconds));
}

isPresent(SerializableFinder byValueKey, FlutterDriver driver, {Duration timeout = const Duration(seconds: 20)}) async {
  try {
    await driver.waitFor(byValueKey,timeout: timeout);
    return true;
  } catch(exception) {
    return false;
  }
}

void main() {
  load();

  group('Supernode App', () {

    // All-Purpose

    final exitPage = find.byValueKey('navActionButton');

    // Login Screen

    final logoFinder = find.byValueKey('homeLogo');
    final loginFinder = find.byValueKey('homeLogin');
    final menuFinder = find.byValueKey('homeSupernodeMenu');
    final emailFieldFinder = find.byValueKey('homeEmail');
    final passwordFieldFinder = find.byValueKey('homePassword');
    final testServerFinder = find.byValueKey('MXCbuild');
    final scrollMenu = find.byValueKey('scrollMenu');
    final mxcChinaFinder = find.byValueKey('MXCChina');
    final questionCircle = find.byValueKey('questionCircle');

    // Dashboard

    final calculatorButtonDashboard = find.byValueKey('calculatorButton');
    final depositButtonDashboard = find.byValueKey('depositButtonDashboard');
    final checkEmailApi = find.text('test@mxc.org');
    final withdrawButtonDashboard = find.byValueKey('withdrawButtonDashboard');
    final totalGatewaysDashboard = find.byValueKey('totalGatewaysDashboard');
    final stakeButtonDashboard = find.byValueKey('stakeButtonDashboard');
    final settingsButtonDashboard = find.byValueKey('settingsButton');

    // Top-Up Page

    final ethAddressTopUp = find.byValueKey('ethAddressTopUp');
    final qrCodeTopUp = find.byValueKey('qrCodeTopUp');

    // Stake Page

    final stakeFlex = find.byValueKey('stakeFlex');
    final stakeAmount = find.byValueKey('stakeAmount');
    final stakeButton = find.byValueKey('stakeButton');
    final submitButtonTimeout = find.byValueKey('submitButtonTimeout');

    // Question Circles

    final helpTextFinder = find.byValueKey('helpText');

    // Settings
    final logoutFinder = find.byValueKey('logout');


    FlutterDriver driver;

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    delay(5000);

    test('login help bubble works', () async {

      await driver.waitUntilFirstFrameRasterized();

      delay(5000);
      print('LOCATING THE MXC LOGO');

      await driver.waitFor(logoFinder);

      print('CLICK QUESTION CIRCLE');
      await driver.waitFor(questionCircle);
      await driver.tap(questionCircle);
      // find solution for testing all languages
      await driver.waitFor(helpTextFinder);
      final helpTextExists = await isPresent(helpTextFinder, driver);
      expect(helpTextExists, true);
      // Needs exit
    });

    test('can login', () async {

      await driver.waitUntilFirstFrameRasterized();

      delay(5000);
      print('LOCATING THE MXC LOGO');

      await driver.waitFor(logoFinder);

      print('LOADED, BEGINNING THE TAP');

      for (var i = 0; i < 7; i++) {
        await driver.tap(logoFinder);
        delay(20);
        print('TAP ${i + 1}');
      }

      print('ALL TAPPED OUT, LETS SELECT THAT SERVER');

      await driver.tap(menuFinder);
      delay(2000);
      await driver.scrollUntilVisible(scrollMenu, mxcChinaFinder);
      await driver.tap(testServerFinder);

      print('SERVER SELECTED, TIME TO ENTER CREDENTIALS');

      await driver.waitFor(emailFieldFinder);
      await driver.tap(emailFieldFinder);
      await driver.enterText(env['TESTING_USER']);
      await driver.waitFor(find.text(env['TESTING_USER']));
      await driver.tap(passwordFieldFinder);
      await driver.enterText(env['TESTING_PASSWORD']);

      print('THE MOMENT HAS COME, WILL IT WORK?');

      await driver.tap(loginFinder);

      expect(await driver.getText(totalGatewaysDashboard), 'Revenue');

      print('HOUSTON, WE ARE LOGGED IN');

    }, timeout:Timeout(Duration(seconds: 60)));

    // test('has top up address', () async {
    //
    //   print('CHECKING TOP-UP API');
    //   await driver.tap(depositButtonDashboard);
    //   await driver.tap(exitPage);
    //   await driver.tap(depositButtonDashboard);
    //   await driver.waitFor(qrCodeTopUp);
    //   expect(await driver.getText(ethAddressTopUp), '0x9bfd604ef6cbfdca05e9eae056bc465c570c09e8');
    //   await driver.tap(exitPage);
    //
    // }, timeout:Timeout(Duration(seconds: 60)));

    // test('can withdraw', () async {
    //       print('NAVIGATE TO WITHDRAW');
    //       await driver.waitFor(withdrawButtonDashboard);
    //       await driver.tap(withdrawButtonDashboard);
    //       print('CHECKING ? BUTTON');
    //       await driver.waitFor(questionCircle);
    //       await driver.tap(questionCircle);
    //       delay(5000);
    //       var isExists = await isPresent(helpTextFinder, driver);
    //       expect(isExists, true);
    //       delay(5000);
    //       await driver.waitFor(logoFinder);
    //       //not sure how to click something that isn't labelled so the you must close the help box manually for now
    // }, timeout:Timeout(Duration(seconds: 60)));


    //complete withdraw test


// Staking Test doesn't Work
//     test('can set stake', () async {
//       /*
//       Not clickable yet
//       print('CHECKING ? BUTTON');
//       await driver.waitFor(questionCircle);
//       await driver.tap(questionCircle);
//       delay(5000);
//       var isExists = await isPresent(find.byValueKey('helpText'), driver);
//       expect(isExists, true);
//       delay(5000);
//       await driver.waitFor(logoFinder);
//       //not sure how to click something that isn't labelled so the you must close the help box manually for now
//        */
//
//       await driver.tap(stakeButtonDashboard);
//       await driver.tap(stakeFlex);
//       await driver.tap(stakeAmount);
//       await driver.enterText('20');
//       await driver.waitFor(find.text('20'));
//       await driver.tap(stakeButton);
//       await driver.waitFor(find.text('(0)'));
//       await delay(200);
//       await driver.waitFor(submitButtonTimeout);
//       await driver.tap(submitButtonTimeout);
//       await driver.tap(exitPage);
//
//
//     }, timeout:Timeout(Duration(seconds: 60)));


    // Logout Test Works
    test('can logout', () async {
      await driver.tap(settingsButtonDashboard);
      await driver.tap(logoutFinder);
      await driver.waitFor(logoFinder);
      final logoIsPresent = await isPresent(logoFinder, driver);
      expect(logoIsPresent, true);
    });



  });


}