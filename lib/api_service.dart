import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import './config.dart';
import './models/customer_model.dart';
import './models/login_response.dart';
import './models/category_model.dart';
import './models/product_model.dart';

class APIService {
  Future<bool> createUser(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.key + ':' + Config.secret),
    );
    var ret = false;
    try {
      var respose = await Dio().post(Config.userUrl,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            // 'Basic eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcWFhd3MuY29tIiwiaWF0IjoxNjAzNDEwOTg3LCJuYmYiOjE2MDM0MTA5ODcsImV4cCI6MTYwNDAxNTc4NywiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMSJ9fX0.ZMwZX3RIwYxL-_JjHPMSZec0uwPvm0ANPbGe-66m41Y',
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.contentTypeHeader: 'application/json'
          }));
      if (respose.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (error) {
      print(error.response);
      if (error.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<LoginResponse> loginUser(String username, String password) async {
    LoginResponse loginResponse;
    var authorization =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var authToken = base64.encode(
      utf8.encode(Config.key + ':' + Config.secret),
    );

    // try {
    var response = await Dio().post(
      Config.tokenURL,
      data: {
        'username': username,
        'password': password,
      },
      options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
        HttpHeaders.contentTypeHeader: 'application/x-www-from-urlencoded'
      }, responseType: ResponseType.json),
    );
    print('rea');
    print('response ${response.data}');
    if (response.statusCode == 200) {
      loginResponse = LoginResponse.fromJson(response.data);
    }
    // } on DioError catch (e) {
    //   print('error:${e.message}');
    //   throw e;
    // }
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> model = [];
    try {
      String url = Config.url +
          Config.categoryUrl +
          '?consumer_key=${Config.key}&consumer_secret=${Config.secret}';
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        (response.data as List)
            .map(
              (category) => model.add(
                CategoryModel.fromJson(category),
              ),
            )
            .toList();
      }
    } on DioError catch (error) {
      print(error.response);
    }
    print('yy');

    return model;
  }

  Future<List<ProductModel>> getProducts({String tagId}) async {
    String params = tagId != null ? '&tag=$tagId' : '';
    List<ProductModel> data = [];
    try {
      String url = Config.url +
          Config.productUrl +
          '?consumer_key=${Config.key}&consumer_secret=${Config.secret}$params';
      print(url);
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      print('dd');
      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        (response.data as List)
            .map(
              (product) => data.add(
                ProductModel.fromJson(product),
              ),
            )
            .toList();
      }
    } on DioError catch (error) {
      print('error');
      print(error.response);
    }
    print('sss');
    print(data);
    return data;
  }
}
