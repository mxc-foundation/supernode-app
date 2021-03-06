import 'package:flutter_driver/flutter_driver.dart';
import 'package:dotenv/dotenv.dart' show env;

// Naming Convention 'page' + 'DescribeItem'

Map f = {
  'logoFinder': find.byValueKey('homeLogo'),
  'loginFinder': find.byValueKey('homeLogin'),
  'menuFinder': find.byValueKey('homeSupernodeMenu'),
  'navBarMiners': find.byValueKey('bottomNavBar_Gateway'),
  'emailFieldFinder': find.byValueKey('homeEmail'),
  'passwordFieldFinder': find.byValueKey('homePassword'),
  'scrollMenu': find.byValueKey('scrollMenu'),
  'mxcChinaFinder': find.byValueKey('MXCChina'),
  'questionCircle': find.byValueKey('questionCircle'),
  'totalGatewaysDashboard': find.byValueKey('totalGatewaysDashboard'),
  'helpTextFinder': find.byValueKey('helpText'),
  'infoDialog': find.byValueKey('infoDialog'),
  'stakeFlex': find.byValueKey('stakeFlex'),
  'stakeAmount': find.byValueKey('stakeAmount'),
  'minersAddIcon': find.byValueKey('minersAddIcon'),
  'totalMinersTitle': find.byValueKey('totalMinersTitle'),
  'totalMinersSubtitle': find.byValueKey('totalMinersSubtitle'),
  'minersRevenue': find.byValueKey('minersRevenue'),
  'addMinerSerialNumber': find.byValueKey('addMinerSerialNumber'),
  'addMinerSubmit': find.byValueKey('addMinerSubmit'),
  'minersNewMiner': find.text('Gateway_' + env['DRIVE_MINER_SERIAL']),
  'minerDeleteButton': find.text('Delete'),
  'minerConfirmDeleteButton':
      find.byValueKey('delete_gateway_bottom_dialog_item2'),
  'minerDetailsMapbox': find.byValueKey('minerDetailsMapbox'),
  'minerDetailsAltitude': find.byValueKey('minerDetailsAltitude'),
  'minerDetailsCoordinates': find.byValueKey('minerDetailsCoordinates'),
  'minerDetailsMinerId': find.byValueKey('minerDetailsMinerId'),
  'minerDetailsLastSeen': find.byValueKey('minerDetailsLastSeen'),
  'minerDetailsWeeklyRevenue': find.byValueKey('miningChart'),
  'minerDetailsFrame': find.byValueKey('minerDetailsFrame'),
  'minerDetailsMinerModel': find.byValueKey('minerDetailsMinerModel'),
  'minerDetailsMinerOS': find.byValueKey('minerDetailsMinerOS'),
  'submitButton': find.byValueKey('submitButton'),
  'backButton': find.byValueKey('backButton'),
  'successIconFinder': find.byValueKey('successIcon_true'),
  'stakeAmountView': find.byValueKey('stakeAmountView'),
  'stakeButtonDashboard': find.byValueKey('stakeButtonDashboard'),
  'depositButtonDashboard': find.byValueKey('depositButtonDashboard'),
  'exitPage': find.byValueKey('navActionButton'),
  'settingsButtonDashboard': find.byValueKey('settingsButton'),
  'logoutFinder': find.byValueKey('logout'),
  'navbarWalletButton': find.byValueKey('bottomNavBar_Wallet'),
  'walletAccountStakeButton': find.byValueKey('tabBar_stake'),
  'walletStakeUnstakeButton': find.byValueKey('unstake'),
  'homeProfile': find.byValueKey('homeProfile'),
  'homeProfileSubtitle': find.byValueKey('homeProfileSubtitle'),
  'totalDevicesDashboard': find.byValueKey('totalDevicesDashboard'),
  'homeCurrentBalanceLabel': find.byValueKey('homeCurrentBalanceLabel'),
  'homeCurrentBalance': find.byValueKey('homeCurrentBalance'),
  'homeStakedAmountLabel': find.byValueKey('homeStakedAmountLabel'),
  'homeStakedAmount': find.byValueKey('homeStakedAmount'),
  'homeStakingRevenueLabel': find.byValueKey('homeStakingRevenueLabel'),
  'homeStakingRevenue': find.byValueKey('homeStakingRevenue'),
  'homeMapbox': find.byValueKey('homeMapbox'),

  // Later unstakeStakedToken will need to be managed directly in the staking_test.dart file
  // so that we can unstake specific to the recently created stake

  'unstakeStakedToken': find.byValueKey('stakeItem_0'),
  'primaryButton': find.byValueKey('primaryButton'),
  'otpEnterOtp': find.byValueKey('otp_0'),
  'otpConfirmOtpButton': find.byValueKey('confirmOtp'),
  'navbarHomeButton': find.byValueKey('bottomNavBar_Home'),
  'unstakeStakesList': find.byValueKey('stakesList'),
  'unstakePage': find.byValueKey('unstakePage')
};
