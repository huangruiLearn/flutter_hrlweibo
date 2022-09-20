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

  Future<void> post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    requestHttp(url, successCallBack, "post", params, errorCallBack);
  }

  void requestHttp(String url, Function successCallBack, String method,
      FormData? params, Function errorCallBack) async {
    Response? response;
    try {
      response = await dio.post(url, data: params);
    } on DioError catch (error) {
      if (Constant.ISDEBUG) {
        print('请求异常: ' + error.toString());
      }
      errorCallBack(error.message);
    }
    if (Constant.ISDEBUG) {
      print('请求url: ' + url);
      print('请求头: ' + dio.options.headers.toString());
      print('请求参数: ' + params.toString());
      print('返回参数: ' + response.toString());
    }
    String dataStr = json.encode(response?.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap['status'] != 200) {
      errorCallBack(dataMap['msg'].toString());
    } else {
      successCallBack(dataMap);
    }
  }
}
