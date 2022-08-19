import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../constants/api_path.dart';
import '../networks/api_exceptions.dart';
import '../networks/api_response.dart';

class APIService {
  Future<dynamic> getAsync(String url) async {
    ApiResponse responseJson;
    try {
      var uri = Uri.parse(url);
      //  var header = { "User-Agent":"BastionDiscordBot (https://bastionbot.org, v6.3)"};
      if (kDebugMode) {
        print('Get Api Address :- $url');
      }
      final response = await get(uri);
      responseJson = _returnResponse(response);
      if (responseJson.data is List) {
        return responseJson.data != null ? List.from(responseJson.data) : null;
      } else {
        return responseJson.data;
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<String> getAccessToken() async {
    final response = await post(Uri.parse(API.apiURL), headers: {'Authorization': 'Basic 1234'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    if (kDebugMode) {
      print(
          'Request getAccessToken failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    }
    throw response;
  }

  ApiResponse _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        if (kDebugMode) {
          print(responseJson);
        }
        return ApiResponse(responseJson);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with server. Status Code: ${response.statusCode}');
    }
  }
}
