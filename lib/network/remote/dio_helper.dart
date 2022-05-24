import 'package:dio/dio.dart';

class DioHelper
{
 static late  Dio dio;

static init()
{
  dio =Dio(
    BaseOptions(
      // dah 3sahn ash8l ane api ll news wala eh
       baseUrl:'https://newsapi.org/' ,
      //baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );
}

static Future<Response> getData({
  required String url ,
   Map<String,dynamic>? query,
  String lang ='en',
  String? token,
  // aw Map<String,Dynamic>query
})async
{
  dio.options.headers=
      {
        'Content-Type':'application/json',
        'lang':  lang,
        'Authorization': token??'',
      };
 return await dio.get(
     url ,
   queryParameters: query,

 );
}

static Future<Response> postData ({
  required String url ,
  required Map<String,dynamic>? data,
  Map<String,dynamic>? query,
  String lang ='en',
  String? token,
}) async
{
  dio.options.headers = {
    'lang':  lang,
    'Authorization':  token??'',
  };
  return  dio.post(
    url,
    data: data,
    queryParameters: query,

  );
}


 static Future<Response> putData ({
   required String url ,
   required Map<String,dynamic>? data,
   Map<String,dynamic>? query,
   String lang ='en',
   String? token,
 }) async
 {
   dio.options.headers = {
     'lang':  lang,
     'Authorization':  token??'',
   };
   return  dio.put(
     url,
     data: data,
     queryParameters: query,

   );
 }

}