import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';

class StorageRepository {
  static SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  List<Currency> selectedCurrencies() {
    final currenciesKeys =
        _sharedPreferences.getStringList('selected_currencies');
    if (currenciesKeys == null)
      return [
        Currency.mxc,
        Currency.cny,
        Currency.usd,
        Currency.rub,
        Currency.krw,
        Currency.jpy,
        Currency.eur,
        Currency.try0,
        Currency.vnd,
        Currency.idr,
        Currency.brl,
      ];
    if (!currenciesKeys.contains(Currency.mxc.shortName)) {
      currenciesKeys.insert(0, Currency.mxc.shortName);
    }
    final currencyMap = Currency.values
        .asMap()
        .map((key, value) => MapEntry(value.shortName, value));
    return currenciesKeys.map((e) => currencyMap[e]).toList();
  }

  Future<void> setSelectedCurrencies(List<Currency> currencies) async {
    await _sharedPreferences.setStringList(
      'selected_currencies',
      currencies.map((e) => e.shortName).toList(),
    );
  }

  List<AddressEntity> addressBook() {
    final addressBook = _sharedPreferences.getStringList('address_book');
    if (addressBook == null) return [];
    return addressBook.map((e) => AddressEntity.fromJson(e)).toList();
  }

  Future<void> setAddressBook(List<AddressEntity> currencies) async {
    await _sharedPreferences.setStringList(
      'address_book',
      currencies.map((e) => e.toJson()).toList(),
    );
  }

  bool showFeedback() {
    final res = _sharedPreferences.getBool('feedback');
    return res ?? false;
  }

  Future<void> setShowFeedback(bool val) async {
    await _sharedPreferences.setBool('feedback', val);
  }

  static const String _orgIdKey = 'org_id';

  String organizationId() {
    return _sharedPreferences.getString(_orgIdKey);
  }

  Future<void> setOrganizationId(String orgId) async {
    await _sharedPreferences.setString(_orgIdKey, orgId);
  }

  static const String _tokenKey = "jwt";
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _demoModeKey = 'demo_mode';
  static const String _supernodeKey = 'supernode';

  StorageManagerSupernodeUser supernodeSession() {
    final token = _sharedPreferences.getString(_tokenKey);
    final userId = _sharedPreferences.getInt(_userIdKey);
    final username = _sharedPreferences.getString(_userNameKey);
    final password = _sharedPreferences.getString(_passwordKey);
    final supernodeString = _sharedPreferences.getString(_supernodeKey);
    final supernode =
        supernodeString == null ? null : Supernode.fromJson(supernodeString);

    if (token == null ||
        userId == null ||
        username == null ||
        password == null ||
        supernode == null) return null;

    return StorageManagerSupernodeUser(
      jwt: token,
      userId: userId,
      username: username,
      password: password,
      supernode: supernode,
    );
  }

  Future<void> setSupernodeSession({
    @required String jwt,
    @required int userId,
    @required String username,
    @required String password,
    @required Supernode supernode,
  }) async {
    await _sharedPreferences.setString(_tokenKey, jwt);
    await _sharedPreferences.setInt(_userIdKey, userId);
    await _sharedPreferences.setString(_userNameKey, username);
    await _sharedPreferences.setString(_passwordKey, password);
    await _sharedPreferences.setString(_supernodeKey, supernode?.toJson());
  }

  static const String _dataHighwayAddress = 'dataHighwayAddress';

  String dataHighwaySession() {
    final address = _sharedPreferences.getString(_dataHighwayAddress);
    return address;
  }

  Future<void> setDataHighwaySession({
    @required String address,
  }) async {
    await _sharedPreferences.setString(_dataHighwayAddress, address);
  }

  bool isDemo() {
    return _sharedPreferences.getBool(_demoModeKey);
  }

  Future<void> setIsDemo(bool val) async {
    await _sharedPreferences.setBool(_demoModeKey, val);
  }

  Locale locale() {
    return Locale(_sharedPreferences.getString('locale'));
  }

  Future<void> setLocale(Locale locale) async {
    await _sharedPreferences.setString('locale', locale.languageCode);
  }
}

class StorageManagerSupernodeUser {
  final String jwt;
  final int userId;
  final String username;
  final String password;
  final Supernode supernode;

  StorageManagerSupernodeUser({
    this.jwt,
    this.userId,
    this.username,
    this.password,
    this.supernode,
  });
}
