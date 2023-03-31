import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://aryaas.hawkssolutions.com/basicapi/public/v1/';

class BaseClient {
  var client = http.Client();
String offset ="0";
  //GET
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {

      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> post(String api) async {
    var url = Uri.parse(baseUrl + api);
    //var _payload = json.encode(object);
    var _payload={
      "offset": offset,
      "pageLimit": "100",
      "table": "products"
    };
    var _headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhcnlhYXMiLCJuYW1lIjoiSGF3a3MgU29sdXRpb25zIiwiYWRtaW4iOnRydWV9.BoaclKRc8ZpUbWFoQ0tv80RRncyXtRypI6jDVIJQOas',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      print("aryaas api response"+response.body);
      return response.body;

    } else {
      //throw exception and catch it in UI
    }
  }

  ///PUT Request
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }
}