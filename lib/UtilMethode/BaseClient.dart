// ignore_for_file: depend_on_referenced_packages, file_names, constant_identifier_names, await_only_futures

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:gomechanic/UtilMethode/appexpenstion.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class BaseClient{
  static const int TIME_OUT_DURATION = 40;
  String? token;
  Future<dynamic> post(String url, dynamic body)async
  {
    var uri=Uri.parse(url);
    var payload=body;
    try {
      var response=await http.post(uri,
          headers:   {
            'x-api-key': 'api@carmachanic.com',
          },
          body: payload).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  Future<dynamic> get(String url, [Map<String, dynamic>? bodyRequest])async
  {
    var uri=Uri.parse(url);
    try {
      var response=await http.get(uri,
        headers:   {
          'x-api-key': 'api@carmachanic.com',
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException('Error occurred with code : ${response.statusCode}', response.request!.url.toString());
    }
  }

  postMultiple(String postFeedBack, List<XFile> list, read, String catid, msg) {}


  Future<dynamic> profileUpdate(String url,var bodyreq, path)async
  {
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('profile',path));
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key': 'api@carmachanic.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> shopUpdate(String url,var bodyreq, path)async
  {
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('shop_photo',path));
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key': 'api@carmachanic.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }


  Future<dynamic> underDeliverImage(var bodyreq, String url, path)async
  {
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('image1', path));
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key': 'api@carmachanic.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }


  Future<dynamic> bookingStatus(var bodyreq, String url, String doc1, String doc2, String doc3, String doc4) async {
    var uri = Uri.parse(url);
    try {
      var request = http.MultipartRequest("POST", uri);
      if (doc1.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image1', doc1));
      }
      if (doc2.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image2', doc2));
      }
      if (doc3.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image3', doc3));
      }
      if (doc4.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image4', doc4));
      }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key': 'api@carmachanic.com'});
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }



}