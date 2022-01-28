import 'package:dio/dio.dart';

class AuthService{
  static const url = "https://a597-157-47-92-161.ngrok.io";
  Dio dio = new Dio();

  signup(username, password) async {
    try {
      var response = await dio.post('$url/auth/signup',
        data: { "username" : username, "password" : password },
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
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
