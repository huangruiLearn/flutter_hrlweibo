import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_hrlweibo/public.dart';

class DioManager {
  //写一个单例
  //在 Dart 里，带下划线开头的变量是私有变量
  static DioManager _instance;

  static DioManager getInstance() {
    if (_instance == null) {
      _instance = DioManager();
    }
    return _instance;
  }

  Dio dio = new Dio();

  DioManager() {
    dio.options.baseUrl = Constant.baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(LogInterceptor(responseBody: true)); //是否开启请求日志
    //  dio.interceptors.add(CookieManager(CookieJar()));//缓存相关类，具体设置见https://github.com/flutterchina/cookie_jar
  }

//get请求
  get(String url, FormData params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, 'get', params, errorCallBack);
  }

  //post请求
  post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, "post", params, errorCallBack);
  }

  //post请求
  postNoParams(
      String url, Function successCallBack, Function errorCallBack) async {
    _requstHttp(url, successCallBack, "post", null, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method, FormData params, Function errorCallBack]) async {
    Response response;
    try {
      if (method == 'get') {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 201);
      }
      // debug模式才打印
      if (Constant.ISDEBUG) {
        print('请求异常: ' + error.toString());
      }
      _error(errorCallBack, error.message);
      return '';
    }
    // debug模式打印相关数据
    if (Constant.ISDEBUG) {
      print('请求url: ' + url);
      print('请求头: ' + dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }

    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['status'] != 200) {
      _error(errorCallBack, dataMap['msg'].toString());
    } else if (successCallBack != null) {
      successCallBack(dataMap);
    }
  }

  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}

Future request(url, {formData}) async {
  Response response;
  Dio dio = new Dio();
  dio.options.contentType = ContentType.parse("application/json;charset=UTF-8");
  if (formData == null) {
    response = await dio.post(url);
  } else {
    response = await dio.post(url, data: formData);
  }

  /// 打印请求相关信息：请求地址、请求方式、请求参数
  print('请求地址：【' + '  ' + url + '】');
  print('请求参数：' + formData.toString());
  dio.interceptors.add(LogInterceptor(responseBody: true)); //是否开启请求日志

  // print('登录接口的返回值:'+response.data);

  if (response.statusCode == 200) {
    print('响应数据：' + response.toString());
    /*  var  obj=new Map<String, dynamic>.from(response.data);
        int code=obj['status'];
        String msg=obj['msg'];
        if (code== 200) {
           Object data=obj['data'];
           return data;
        }else{
          ToastUtil.show(msg);
        }*/
    return response.data;
  } else {
    print('后端接口出现异常：');

    throw Exception('后端接口出现异常');
  }
}
