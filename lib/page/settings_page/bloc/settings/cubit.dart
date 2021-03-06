import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/server_info.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';

import 'state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
      {this.appCubit,
      this.supernodeUserCubit,
      this.supernodeCubit,
      this.supernodeRepository,
      this.language})
      : super(SettingsState(
            screenShot: false,
            showWechatUnbindConfirmation: false,
            showBindShopifyStep: 0,
            showLoading: false,
            language: 'auto'));

  final AppCubit appCubit;
  final SupernodeUserCubit supernodeUserCubit;
  final SupernodeCubit supernodeCubit;
  final SupernodeRepository supernodeRepository;
  final String language;

  Future<void> initState() async {
    emit(state.copyWith(language: language));
  }

  ServerInfoDao _buildServerInfoDao() {
    return supernodeRepository.serverInfo;
  }

  Future<void> initAboutPage() async {
    PackageInfo.fromPlatform().then((info) => emit(state.copyWith(info: info)));

    _buildServerInfoDao()
        .appServerVersion()
        .then((info) => emit(state.copyWith(mxVersion: info.version)));

    updateCopyrightYear();
  }

  Future<void> updateLanguage(String language, Locale locale) async {
    appCubit.setLocale(locale);
    emit(state.copyWith(language: language));
  }

  void updateCopyrightYear() {
    emit(state.copyWith(copyrightYear: DateTime.now().year));
  }

  void setScreenShot(bool value) {
    emit(state.copyWith(screenShot: value));
  }

  void onUnbind(String service) {
    emit(
        state.copyWith(showWechatUnbindConfirmation: false, showLoading: true));

    Map data = {
      "organizationId": supernodeCubit.state.orgId,
      "service": service
    };

    supernodeRepository.user.unbindExternalUser(data).then((res) async {
      if (service == ExternalUser.weChatService) {
        supernodeUserCubit.removeWeChatUser();
      } else if (service == ExternalUser.shopifyService) {
        supernodeUserCubit.removeShopifyUser();
      }
      await supernodeUserCubit.refreshUser();
      emit(state.copyWith(showLoading: false));
    }).catchError((err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError('Unbind: $err');
    });
  }

  void showWechatUnbindConfirmation(bool confirm) {
    emit(state.copyWith(showWechatUnbindConfirmation: confirm));
  }

  void bindShopifyStep(int step) {
    if (step == 0 || step == 1)
      emit(state.copyWith(showBindShopifyStep: step));
    else
      appCubit.setError('Invalid step');
  }

  void shopifyEmail(String email, String languageCode, String countryCode) {
    emit(state.copyWith(showLoading: true));
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }

    Map apiData = {
      "email": email,
      "language": languageCode,
      "organizationId": supernodeCubit.state.orgId
    };

    supernodeRepository.user.verifyExternalEmail(apiData).then((res) {
      emit(state.copyWith(showBindShopifyStep: 2, showLoading: false));
    }).catchError((err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError('verifyExternalEmail: $err');
    });
  }

  void shopifyEmailVerification(String verificationCode) {
    if (verificationCode.isNotEmpty) {
      emit(state.copyWith(showLoading: true));

      Map apiData = {
        "organizationId": supernodeCubit.state.orgId,
        "token": verificationCode
      };

      supernodeRepository.user.confirmExternalEmail(apiData).then((res) async {
        await supernodeUserCubit.refreshUser();
        emit(state.copyWith(showBindShopifyStep: 3, showLoading: false));
      }).catchError((err) {
        emit(state.copyWith(showLoading: false));
        appCubit.setError('confirmExternalEmail: $err');
      });
    }
  }

  void update(
      String username, String email, String orgName, String orgDisplayName) {
    if (supernodeUserCubit.state.username == username &&
        supernodeUserCubit.state.email == email &&
        supernodeUserCubit.state.organizations.value[0]?.organizationName ==
            orgName &&
        supernodeUserCubit.state.organizations.value[0]?.orgDisplayName ==
            orgDisplayName) return;

    if (supernodeUserCubit.state.username != username ||
        supernodeUserCubit.state.email != email) {
      emit(state.copyWith(showLoading: true));
      Map data = {
        "id": supernodeCubit.state.session.userId,
        "username": username,
        "email": email,
        "sessionTTL": 0,
        "isAdmin": true,
        "isActive": true,
        "note": ""
      };

      supernodeRepository.user.update({"user": data}).then((res) async {
        String jwt = res['jwt'];
        if (jwt != null && jwt.isNotEmpty) {
          supernodeCubit.setSupernodeSession(
            supernodeCubit.state.session.copyWith(
              token: jwt,
              username: username,
            ),
          );
        }
        supernodeUserCubit.emit(supernodeUserCubit.state
            .copyWith(username: username, email: email));
        await supernodeUserCubit.refreshUser();
        emit(state.copyWith(showLoading: false));
      }).catchError((err) {
        emit(state.copyWith(showLoading: false));
        appCubit.setError('user.update: $err');
      });
    }

    if (supernodeUserCubit.state.organizations.value[0]?.organizationName !=
            orgName ||
        supernodeUserCubit.state.organizations.value[0]?.orgDisplayName !=
            orgDisplayName) {
      emit(state.copyWith(showLoading: true));

      Map dataOrg = {
        "id": supernodeUserCubit.orgId,
        "organization": {
          "id": supernodeUserCubit.orgId,
          "name": orgName,
          "displayName": orgDisplayName,
          "canHaveGateways": true
        }
      };

      supernodeRepository.organization.update(dataOrg).then((res) async {
        await supernodeUserCubit.refreshUser();
        emit(state.copyWith(showLoading: false));
      }).catchError((err) {
        emit(state.copyWith(showLoading: false));
        appCubit.setError('Organization update: $err');
      });
    }
  }

  Future<void> initExportMxcPreYearPage(
      int year, FiatCurrency fiatPreviousSession) async {
    emit(
        state.copyWith(startDate: DateTime(year), endDate: DateTime(year + 1)));

    if (state.listFiat == null) {
      emit(state.copyWith(showLoading: true));

      try {
        final List<FiatCurrency> listFiat =
            await supernodeRepository.user.supportedFiatCurrencies();

        emit(state.copyWith(listFiat: listFiat, showLoading: false));
      } catch (e) {
        emit(state.copyWith(showLoading: false));
        appCubit.setError(e.toString());
      }

      if (state.listFiat != null) {
        FiatCurrency initFiat;
        if (fiatPreviousSession == null ||
            fiatPreviousSession.id == null ||
            fiatPreviousSession.id.isEmpty) {
          initFiat = (state.listFiat == null || state.listFiat.length < 1)
              ? null
              : state.listFiat[0];
        } else {
          initFiat = fiatPreviousSession;
        }
        emit(state.copyWith(selectedFiat: initFiat));
      }
    }
  }

  void setFormat(String format) {
    emit(state.copyWith(format: format));
  }

  void setFiatCurrency(FiatCurrency selectedFiat) {
    appCubit.setSelectedFiatForExport(selectedFiat);
    emit(state.copyWith(selectedFiat: selectedFiat));
  }

  void changeDataExportDecimals(int difference) {
    if (state.decimals + difference >= 0 && state.decimals + difference <= 18)
      emit(state.copyWith(decimals: state.decimals + difference));
  }

  Future<String> exportData() async {
    if (state.selectedFiat == null || state.selectedFiat.id == null) return "";

    emit(state.copyWith(showLoading: true));

    try {
      Map data = {
        "format": state.format,
        "organizationId": supernodeCubit.state.orgId,
        "currency": 'ETH_MXC',
        "fiatCurrency": state.selectedFiat.id,
        "start": state.startDate.toUtc().toIso8601String(),
        "end": state.endDate.toUtc().toIso8601String(),
        "decimals": state.decimals
      };

      final miningIncomeResponse =
          await supernodeRepository.user.miningIncomeReport(data);

      final path = await createTempFileForResponse(miningIncomeResponse,
          'MiningReport_MXC_${state.selectedFiat.id.toUpperCase()}_year${state.startDate.year}.${state.format}');

      emit(state.copyWith(showLoading: false));
      return path;
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError('Data export: $err');
    }
    return "";
  }

  Future<String> moveTempFile(String source) async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final fileName = source.split('/').last;
    final String fullPath = '$dir/$fileName';
    await File(source).copy(fullPath);
    File(source).delete();
    return fullPath;
  }

  Future<String> createTempFileForResponse(
      String response, String fileName) async {
    final String dir = (await getTemporaryDirectory()).path;
    final String fullPath = '$dir/$fileName';
    final File report = new File(fullPath);
    report.openWrite(mode: FileMode.write);

    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(response);
    Map<String, dynamic> map;
    for (String line in lines) {
      map = jsonDecode(line);
      await report.writeAsBytes(base64.decode(map['result']['data']),
          flush: true, mode: FileMode.append);
    }

    return fullPath;
  }
}
