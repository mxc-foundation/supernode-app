import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:supernodeapp/common/configs/sys.dart';
import 'package:supernodeapp/common/daos/interceptors/log_interceptor.dart';
import 'package:supernodeapp/common/daos/interceptors/token_interceptor.dart';

class Dao{
  static String baseUrl = '';
  static String token = '';

  bool inProduction = const bool.fromEnvironment('dart.vm.product');

  bool isMock = false;
   
  Response response;
  Dio dio = new Dio();

  Dao(){
    dio.options.baseUrl = inProduction ? baseUrl : Sys.testBaseUrl; // Sys.buildBaseUrl
    dio.interceptors.add(TokenInterceptors());
    dio.interceptors.add(LogsInterceptors());

  }

  Future<dynamic> post({String url,dynamic data}) async{
    try {
      Response response = await dio.post(
        url,
        data: JsonEncoder().convert(data),
      );

      if(response.statusCode == 200){
        return response.data;
      }

    }on DioError catch(e) {
      throw e.response != null ? e.response.data['message'] : e.message;
    }
  }

  Future<dynamic> get({String url,Map data}) async{

    try {
      Response response = await dio.get(
        url,
        queryParameters: data != null ? new Map<String, dynamic>.from(data) : null,
      );

      if(response.statusCode == 200){
        return response.data;
      }

    }on DioError catch(e) {
      throw e.response != null ? e.response.data['message'] : e.message;
    }
  }

  Future<dynamic> put({String url,dynamic data}) async{
    try {
      Response response = await dio.put(
        url,
        data: JsonEncoder().convert(data),
      );

      if(response.statusCode == 200){
        return response.data;
      }

    }on DioError catch(e) {
      throw e.response != null ? e.response.data['message'] : e.message;
    }
  }

}