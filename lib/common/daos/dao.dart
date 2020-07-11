import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/daos/interceptors/log_interceptor.dart';
import 'package:supernodeapp/common/daos/interceptors/token_interceptor.dart';
import 'package:supernodeapp/common/daos/isolate_dao.dart';

class Dao {
  static String baseUrl = '';
  static String token = '';
  static var context;

  bool inProduction = const bool.fromEnvironment('dart.vm.product');
  bool isMock = false;

  Response response;
  static Dio dio = new Dio();

  Dao() {
    dio.options.baseUrl = baseUrl;//inProduction ? baseUrl : Sys.buildBaseUrl;
    dio.interceptors.add(TokenInterceptors());
    dio.interceptors.add(LogsInterceptors());
  }

  Future<dynamic> post({String url, dynamic data}) async {
    try {
      Response response = await dio.post(
        url,
        data: JsonEncoder().convert(data),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      throw e.response != null ? e.response.data['message'] : e.message;
    }
  }

  Future<dynamic> get({String url, Map data}) async {
    try{
      if(!url.contains('http')){
        url = dio.options.baseUrl + url;
      }
      var res = await IsolateDao.receive(url: url,data: data);
      return res;//getMethod(url: url,data: data);
    }catch(e){
      // getMethod(url: url,data: data);
      DaoSingleton.get(url: url,data: data,dio: dio);
    }
    
  }

  Future<dynamic> put({String url, dynamic data}) async {
    try {
      Response response = await dio.put(
        url,
        data: JsonEncoder().convert(data),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      throw e.response != null ? e.response.data['message'] : e.message;
    }
  }
}

class DaoSingleton{
  static Future<dynamic> get({String token,String url, Map data,Dio dio}) async {
    Dio _dio;
    try {
      if(dio != null){
        _dio = dio;
      }else{
        _dio = Dio(
          BaseOptions(
            headers: {
              "Grpc-Metadata-Authorization": token
            }
          )
        );
      } 

      Response response = await _dio.get(
        url,
        queryParameters: data != null ? new Map<String, dynamic>.from(data) : null,
      );

      _dio.lock();

      if (response.statusCode == 200) {
        _dio.unlock();
        return response.data;
      }
    } on DioError catch (e) {
      _dio.unlock();
      throw e.response != null ? e.response.data['message'] : e.message;
    }
  }

  // singleton
  factory DaoSingleton() => _getInstance();

  static DaoSingleton get instance => _getInstance();
  static DaoSingleton _instance;

  DaoSingleton._internal();

  static DaoSingleton _getInstance() {
    if (_instance == null) {
      _instance = new DaoSingleton._internal();
    }
    return _instance;
  }
}

