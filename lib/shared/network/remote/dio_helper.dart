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
      dio!.options.headers = {'Accept':'application/json',
        'Authorization': 'Bearer $token'
         };
    }

    return await dio!.post(url!, queryParameters: query, data: data);
  }

  static Future<dynamic> uploadFile({
    filePath,
    String? token,
    String? url,
  }) async {
    String token = await CashHelper.getData(key: 'token');
    // var _userId = '605b981d4d998b3124a81204';

    try {
      FormData formData =
      new FormData.fromMap({
        "image":
        await MultipartFile.fromFile(filePath, filename: "thumb")});

      Response response =
      await Dio().put(
          'http://18.221.253.60:83/api/dashboard/v1/products',
          data: formData,
          options: Options(
              headers: <String, String>{
                'Authorization': 'Bearer $token',
              }
          )
      );
      return response;
    }on DioError catch (e) {
      return e.response;
    } catch(e){
    }
  }
}
