import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/utils/url.dart';
import 'package:dio/dio.dart';
export 'user.model.dart';

import 'dao.dart';

class UserApi {
  static const String login = '/api/internal/login';
  static const String profile = '/api/internal/profile';
  static const String registration = '/api/internal/registration';
  static const String registrationConfirm =
      '/api/internal/registration-confirm';
  static const String registrationFinish = '/api/internal/registration-finish';

  static const String update = '/api/users/{user.id}';
  static const String password = '/api/users/{userId}/password';

  static const String getTOTPStatus = '/api/internal/totp-status';
  static const String getTOTPConfig = '/api/internal/totp-configuration';
  static const String setEnable =
      '/api/internal/totp-enable'; //OTP code in Grpc-Metadata-X-OTP header
  static const String setDisable = '/api/internal/totp-disable';

  static const String passwordReset = "/api/internal/request-password-reset";
  static const String passwordResetConfirm =
      "/api/internal/confirm-password-reset";

  //ExternalUserService
  static const String authenticateWeChatUser =
      "/api/external-login/authenticate-wechat-user";
  static const String debugAuthenticateWeChatUser =
      "/api/external-login/debug-authenticate-wechat-user";
  static const String bindExternalUser =
      "/api/external-login/bind-external-user";
  static const String registerExternalUser =
      "/api/external-login/register-external-user";
  static const String unbindExternalUser =
      "/api/external-login/unbind-external-user";
  static const String confirmExternalEmail = "/api/confirm-external-email";
  static const String verifyExternalEmail = "/api/verify-external-email";
  static const String supportedFiatCurrencies =
      "/api/report/supported-fiat-currencies";
  static const String miningIncomeReport = "/api/report/mining-income/{format}";
}

class UserDao extends SupernodeDao {
  UserDao(SupernodeHttpClient client) : super(client);

  //remote
  Future<dynamic> register(Map data) {
    return post(
      url: UserApi.registration,
      data: data,
    );
  }

  Future<RegistrationConfirmResponse> registerConfirm(Map data) {
    return post(
      url: UserApi.registrationConfirm,
      data: data,
    ).then((value) => RegistrationConfirmResponse.fromMap(value));
  }

  Future<dynamic> registerFinish(Map data, String token) {
    return post(
      url: UserApi.registrationFinish,
      headers: {'Grpc-Metadata-Authorization': token},
      data: data,
    );
  }

  Future<UserLoginResponse> login(String username, String password) {
    return post(
      url: UserApi.login,
      data: {
        'username': username,
        'password': password,
      },
    ).then((res) => UserLoginResponse.fromMap(res));

    //.then((res) => !isMock ? res : Mock.login)
    // .catchError((err) => !isMock ? err : Mock.login);
  }

  Future<ProfileResponse> profile() {
    return get(
      url: UserApi.profile,
    ).then((value) => ProfileResponse.fromMap(value));
  }

  Future<dynamic> update(Map data) {
    return put(
            url: Api.url(UserApi.update, data['user']['id'].toString()),
            data: data)
        .then((res) => res);
  }

  Future<dynamic> changePassword(Map data) {
    return put(
            url: Api.url(UserApi.password, data['userId'].toString()),
            data: data)
        .then((res) => res);
  }

  //get TOTP Status by Namgyeong
  Future<TotpEnabledResponse> getTOTPStatus() {
    return get(url: UserApi.getTOTPStatus, data: {})
        .then((res) => TotpEnabledResponse.fromMap(res));
  }

  Future<dynamic> getTOTPConfig(Map data) {
    return post(url: UserApi.getTOTPConfig, data: data).then((res) => res);
  }

  Future<TotpEnabledResponse> setEnable(String otp) {
    final data = {"otp_code": otp};
    return post(url: UserApi.setEnable, data: data)
        .then((res) => TotpEnabledResponse.fromMap(res));
  }

  Future<dynamic> setDisable(Map data) {
    return post(url: UserApi.setDisable, data: data).then((res) => res);
  }

  Future<dynamic> passwordReset(Map data) {
    return post(url: UserApi.passwordReset, data: data);
  }

  Future<dynamic> passwordResetConfirm(Map data) {
    return post(url: UserApi.passwordResetConfirm, data: data);
  }

  Future<dynamic> authenticateWeChatUser(Map data) {
    return post(url: UserApi.authenticateWeChatUser, data: data);
  }

  Future<dynamic> debugAuthenticateWeChatUser(Map data) {
    return post(url: UserApi.debugAuthenticateWeChatUser, data: data);
  }

  Future<dynamic> bindExternalUser(Map data) {
    return post(url: UserApi.bindExternalUser, data: data);
  }

  Future<dynamic> registerExternalUser(Map data) {
    return post(url: UserApi.registerExternalUser, data: data);
  }

  Future<dynamic> unbindExternalUser(Map data) {
    return post(url: UserApi.unbindExternalUser, data: data);
  }

  Future<dynamic> verifyExternalEmail(Map data) {
    return post(url: UserApi.verifyExternalEmail, data: data);
  }

  Future<dynamic> confirmExternalEmail(Map data) {
    return post(url: UserApi.confirmExternalEmail, data: data);
  }

  Future<List<FiatCurrency>> supportedFiatCurrencies() {
    return get(url: UserApi.supportedFiatCurrencies).then((res) {
      if (res.containsKey("fiatCurrencyList")) {
        final List<FiatCurrency> list = [];
        res["fiatCurrencyList"]
            .forEach((e) => list.add(FiatCurrency.fromMap(e)));
        return list;
      } else
        return null;
    });
  }

  Future<dynamic> miningIncomeReport(Map data) async {
    return get(
      url: Api.url(UserApi.miningIncomeReport, data['format'].toString()),
      data: data,
      rt: ResponseType.plain,
    );
  }
}
