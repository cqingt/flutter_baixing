import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'dart:convert';

Future request(url, {formData}) async {
  try {
    print('开始获取数据..............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');

    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);     
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端请求错误');
    }
  } catch (e) {
    return print('Error:============>${e}');
  }
}

Future getHomePageContent() async {

  var formData = {'lon': '115.02932', 'lat': '35.76189'};

  return request('homePageContent', formData:formData);
}

// 获取火爆专区内容
Future homePageBelowConten(formData) async {
   return request('homePageBelowConten', formData:formData);
}

Future categoryPageContent() async{
  return request('getCategory');
}