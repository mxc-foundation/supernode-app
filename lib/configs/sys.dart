import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config.dart';

class AppLanguage {
  static const String auto = 'auto';
  static const String en = 'en';
  static const String en_CN = 'en_CN';
  static const String zh_Hans_CN = 'zh_CN';
  static const String zh_Hant_TW = 'zh_TW';
  static const String zh_Hant_HK = 'zh_HK';
  static const String ko = 'ko';
  static const String ja = 'ja';
  static const String tr = 'tr';
  static const String de = 'de';
  static const String ru = 'ru';
  static const String vi = 'vi';
  static const String es = 'es';
  static const String id = 'id';
  static const String pt = 'pt';
  static const String tl = 'tl';
}

class Sys {
  /// Using the Test Url When debugging
  static const testBaseUrl = 'https://lora.test.cloud.mxc.org';
  static const buildBaseUrl = 'https://lora.build.cloud.mxc.org';

  /// Using in the About Page and the Registration Page
  static const impressum = 'https://www.mxc.org/imprint';
  static const privacyPolicy = 'https://www.mxc.org/privacy-policy';
  static const agreePolicy = 'https://www.mxc.org/terms-and-conditions';
  static const stakeMore = 'https://mxc.wiki';

  /// AppCenter Config of init method
  static final appSecretAndroid = DotEnv().env['APPCENTER_SECRET_ANDROID'];
  static final appSecretIOS = DotEnv().env['APPCENTER_SECRET_IOS'];
  static final tokenAndroid = DotEnv().env['APPCENTER_TOKEN_ANDROID'];
  static final tokenIOS = DotEnv().env['APPCENTER_TOKEN_IOS'];
  static final appIdIOS = DotEnv().env['APPCENTER_APPID_IOS'];
  static const betaUrlIOS = 'itms-beta://testflight.apple.com/join/NkXHEpf4';
  static const channelProduct = 'prod';
  static const channelGooglePlay = 'play';

  /// Mapbox
  static const mapTileStyle =
      "mapbox://styles/mxcdatadash/ck9qr005y5xec1is8yu6i51kw";
  static const mapUrlTemplate =
      'https://api.mapbox.com/styles/v1/mxcdatadash/ck9qr005y5xec1is8yu6i51kw/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}';
  static const mapboxjs = 'assets/js/mapbox-gl.js';
  static const mapjs = 'assets/js/map.js';
  static final mapToken = Config.MAP_BOX_ACCESS_TOKEN;

  /// Crashes
  static const crashesUrl = 'https://in.appcenter.ms';
  static const crasheslog = '/logs?Api-Version=1.0.0';

  /// Load data of the location of global gateways
  static const gateways_location_list =
      'assets/others/global_gateways_location.json';
}
