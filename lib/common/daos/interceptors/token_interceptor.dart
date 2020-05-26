import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/configs/config.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';


class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != Null) {
        _token = authorizationCode;
        options.headers["Grpc-Metadata-Authorization"] = _token;
      }
    }
    else{
        options.headers["Grpc-Metadata-Authorization"] = '$_token';
    }
    return options;
  }

  @override
  onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 200 && responseJson[Config.TOKEN_KEY] != null) {
        _token = responseJson[Config.TOKEN_KEY];
        StorageManager.sharedPreferences.setString(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  ///清除授权
  clearAuthorization() async {
    this._token = null;
    await StorageManager.sharedPreferences.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = StorageManager.sharedPreferences.getString(Config.TOKEN_KEY);
    log('${Config.TOKEN_KEY}=$token');
    if (token == null) {
      return Null;
    } else {
      return "$token";
    }
  }
}