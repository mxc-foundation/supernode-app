import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:local_auth/local_auth.dart';
import 'package:supernodeapp/common/utils/log.dart';

class Biometrics {
  Biometrics._();

  static final LocalAuthentication _localAuthentication = LocalAuthentication();

  static Future<bool> _canCheckBiometrics() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      log('canCheckBiometric Exception ', e);
    }
    return canCheckBiometric;
  }

  static Future<List<BiometricType>> _getAvailableBiometricTypes() async {
    return await _localAuthentication.getAvailableBiometrics();
  }

  static Future<void> authenticate(
    BuildContext context, {
    String localizedReason,
    @required VoidCallback authenticateCallback,
    VoidCallback failAuthenticateCallBack,
  }) async {
    final canCheckBiometrics = await Biometrics._canCheckBiometrics();

    final biometricTypes = await Biometrics._getAvailableBiometricTypes();

    if (biometricTypes != null && biometricTypes.isNotEmpty && canCheckBiometrics) {
      try {
        final didAuthenticate = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: localizedReason ?? FlutterI18n.translate(context, 'verify'),
          useErrorDialogs: false,
        );
        if (didAuthenticate) {
          authenticateCallback.call();
        } else {
          failAuthenticateCallBack?.call();
        }
      } on PlatformException catch (e) {
        authenticateCallback.call();
      }
    } else {
      authenticateCallback.call();
    }
  }
}
