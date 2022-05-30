import 'package:app_cafe/models/user/user.dart';
import 'package:app_cafe/services/apis/cafe_api.dart';
import 'package:app_cafe/services/local_storage.dart';
import 'package:dio/dio.dart';

class ClientApi {
  Dio init() {
    Dio _dio = Dio();

    _dio.interceptors.add(CustomInterceptors(_dio));

    _dio.options.baseUrl = "http://caytrongtaynguyen.com/api/";
    _dio.options.receiveTimeout = 100000;
    return _dio;
  }
}

class CustomInterceptors extends QueuedInterceptor {
  final Dio _dio;
  CustomInterceptors(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var accessToken = LocalStorage().token;

    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ' + accessToken;
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // Do something with response error
    if (err.response?.statusCode == 401) {
      RequestOptions options = err.response!.requestOptions;
      // RequestOptions options2 = err.requestOptions;
      Options _options = Options(
        method: options.method,
        headers: options.headers,
        extra: options.extra,
      );
      User user = await CafeService.client()
          .login('client@caytrongtaynguyen.com', 'CtTn@2021');
      LocalStorage.instance.setToken(user.access_token);
      //print(LocalStorage().token);
      _options.headers!["Authorization"] = "Bearer " + LocalStorage().token;

      return _dio.request(
        options.path,
        options: _options,
        data: options.data,
        queryParameters: options.queryParameters,
      );
    }

    super.onError(err, handler);
    return Future.error(err);
  }
}
