import 'package:dio/dio.dart';

class ApiService{
  static const url = "https://a597-157-47-92-161.ngrok.io";
  Dio dio = new Dio();

  getBlogs() async {
    try {
      var response = await dio.get('$url/api/allblogs',
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {"statusload" : false, "feedback" : "Check Internet Connection"};
    }
  }
}
