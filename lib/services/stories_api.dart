import 'package:dio/dio.dart';

class StoriesApi{
  // api Url goes here
  final baseUrl = "";
  late Dio _dio;

  StoriesApi(){
      _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl
        )
      );
      initializeInterceptors();
  }

  initializeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error,errorInterceptorHandler){
        print(error.message);
      },
      onRequest: (request,requestInterceptorHandler){
        print("${request.method} ${request.path}");
      },
      onResponse:( response, responseInterceptorHandler){
          print(response.data);
      }
    ));
  }

  Future<Response> getNews(String endPoint) async{
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
     print(e.message);
     throw Exception(e.message);
    }

    return response;

  }



}