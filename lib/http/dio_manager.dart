import 'package:flutter_hrlweibo/public.dart';


class DioManager {
  static late final DioManager instance = DioManager._internal();

  factory DioManager() => instance;

  static late Dio dio;

  DioManager._internal() {
    var options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
  }


  
  Future<Map<String, dynamic>> post(String url, params,
      [Function? successCallBack, Function? errorCallBack]) async {
    Response? response;
    try {
      response = await dio.post(url, data: params) ;
    }  catch (error) {
      print('请求异常: ' + error.toString());
      if (errorCallBack != null) {
         errorCallBack(error.toString());
      } else {
        return Map<String, dynamic>();
      }
    }
    print('请求url: ' + url);
    print('返回参数: ' + response.toString());
    if (response?.statusCode == 200) {
      Map<String, dynamic> dataMap = json.decode(json.encode(response?.data));
      if (dataMap['status'] == 200) {
        if (successCallBack != null) {
          successCallBack(dataMap['data']);
        } else {
          return dataMap['data'];
        }
      } else {
        if (errorCallBack != null) {
          errorCallBack(dataMap['msg']);
        } else {
          return Map<String, dynamic>();
        }
      }
    } else {
      if (errorCallBack != null) {
        errorCallBack(response.toString());
      } else {
        return Map<String, dynamic>();
      }
    }
    return Map<String, dynamic>();
  }

}
