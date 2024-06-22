import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.1.8:8080';

class BaseClient {
  var client = http.Client();
  static List<String> debugMessages = [];

  void addDebugMessage(String message) {
    debugMessages.add(message);
  }

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      addDebugMessage('GET request failed with status: ${response.statusCode}');
      return null;
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Content-Type': 'application/json',
    };
    var response = await client.post(url, headers: _headers, body: _payload);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body); // Decode the response body and return it
    } else {
      addDebugMessage('POST request failed with status: ${response.statusCode}');
      addDebugMessage('Response body: ${response.body}');
      return null;
    }
  }

  Future<dynamic> put(String api) async {
    // Implement put method if needed
  }
}
