import 'package:dio/dio.dart';

class AuthService{
  static const url = "https://0346-2409-4070-4e14-2243-1877-a2d1-5134-a765.ngrok.io";
  Dio dio = new Dio();

  signup(username, password) async {
    try {
      var response = await dio.post('$url/auth/signup',
        data: { "username" : username, "password" : password },
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      return response.data;
    } on DioError catch (_) {
      return {"statusload" : false, "feedback" : "Check Internet Connection"};
    }
  }

  signin(username, password) async {
    try {
      var response = await dio.post('$url/auth/signin',
        data: { "username" : username, "password" : password },
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      return response.data;
    } on DioError catch (_) {
      return {"statusload" : false, "feedback" : "Check Internet Connection"};
    }
  }

  getUser(token) async {
    try {
      var response = await dio.get('$url/auth/getuser',
      options: Options(headers: { "token" : token })
    );
      return response.data;
    } on DioError catch (_) {
      return {"statusload" : false, "feedback" : "Check Internet Connection"};
    }
  }
}
