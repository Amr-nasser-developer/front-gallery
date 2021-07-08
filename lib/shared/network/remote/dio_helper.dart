import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallary/shared/network/local/cash.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio = Dio(BaseOptions(
     baseUrl: 'http://18.221.253.60:83/api/',
     receiveDataWhenStatusError: true,
      headers: {
        'Accept':'application/json',
      }
    )
    );
  }

  static Future<Response> getData({@required String? url , Map<String , dynamic>? query , String? token})async {
    String token = await CashHelper.getData(key: 'token');
    dio!.options.headers={
      'Accept':'application/json',
      'Authorization': 'Bearer $token'
    };
    return await dio!.get(url!, queryParameters: query);
  }


  static Future<Response> postData({@required String? url , Map<String , dynamic>? query, @required Map<String , dynamic>? data,
    String? token
  })async
  {
    String token = await CashHelper.getData(key: 'token');
    if(token != null){
      dio!.options.headers = {
        'Accept':'application/json',
        'Authorization': 'Bearer $token',
         };
    }

    return await dio!.post(url!, queryParameters: query, data: data);
  }
  static Future<Response> uploadImage({@required String? url , Map<String , dynamic>? query,data,
    String? token
  })async
  {
      dio!.options.headers = {
        'Accept':'application/json',
        'Content-Type':'multipart/form-data'
      };
    return await dio!.post(url!, queryParameters: query, data: data);
  }


}
