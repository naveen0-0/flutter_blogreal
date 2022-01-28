import 'package:dio/dio.dart';

class ApiService{
  static const url = "https://flutterblogrealserver.herokuapp.com";
  Dio dio = new Dio();

  newblog(title, description, creator) async {
    try {
      var response = await dio.post('$url/api/newblog',
        data: { "title" : title, "description" : description, "creator" : creator },
        options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      return response.data;
    } on DioError catch (e) {
      print(e.toString());
      return {"statusload" : false, "feedback" : "Check Internet Connection"};
    }
  }

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
