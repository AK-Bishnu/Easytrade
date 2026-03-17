import 'dart:convert';
import 'package:easytrade_web/core/constants/api_constants.dart';
import 'package:easytrade_web/core/storage/token_storage.dart';
import 'package:file_selector/file_selector.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../storage/refresh_access.dart';

class ApiClient {

  Future<Map<String, String>> _headers() async {
    String? token = await TokenStorage.getToken();

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<dynamic> get(String endpoint) async {

    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + endpoint),
      headers: await _headers(),
    );

    if (response.statusCode == 401) {
      final refreshed = await refreshAccessToken();

      if (refreshed) {
        // retry request with new token
        final retryResponse = await http.get(
          Uri.parse(ApiConstants.baseUrl + endpoint),
          headers: await _headers(),
        );

        if (retryResponse.statusCode == 401) {
          throw Exception("Session expired");
        }

        return jsonDecode(retryResponse.body);
      } else {
        // refresh also failed → logout handled elsewhere
        throw Exception("Session expired");
      }
    }

    return jsonDecode(response.body);
  }

  Future<dynamic> post(String endpoint, Map data) async {

    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + endpoint),
      headers: await _headers(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 401) {
      final refreshed = await refreshAccessToken();

      if (refreshed) {
        // retry request with new token
        final retryResponse = await http.post(
          Uri.parse(ApiConstants.baseUrl + endpoint),
          headers: await _headers(),
          body: jsonEncode(data),
        );

        if (retryResponse.statusCode == 401) {
          throw Exception("Session expired");
        }

        return jsonDecode(retryResponse.body);
      } else {
        // refresh also failed → logout handled elsewhere
        throw Exception("Session expired");
      }
    }

    return jsonDecode(response.body);
  }

  Future<dynamic> put(String endpoint, Map data) async {

    final response = await http.put(
      Uri.parse(ApiConstants.baseUrl + endpoint),
      headers: await _headers(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 401) {
      final refreshed = await refreshAccessToken();

      if (refreshed) {
        // retry request with new token
        final retryResponse = await http.put(
          Uri.parse(ApiConstants.baseUrl + endpoint),
          headers: await _headers(),
          body: jsonEncode(data),
        );

        if (retryResponse.statusCode == 401) {
          throw Exception("Session expired");
        }

        return jsonDecode(retryResponse.body);
      } else {
        // refresh also failed → logout handled elsewhere
        throw Exception("Session expired");
      }
    }

    return jsonDecode(response.body);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse(ApiConstants.baseUrl + endpoint),
      headers: await _headers(),
    );

    if (response.statusCode == 401) {
      final refreshed = await refreshAccessToken();

      if (refreshed) {
        // retry request with new token
        final retryResponse = await http.delete(
          Uri.parse(ApiConstants.baseUrl + endpoint),
          headers: await _headers(),
        );

        if (retryResponse.statusCode == 401) {
          throw Exception("Session expired");
        }

        return jsonDecode(retryResponse.body);
      } else {
        // refresh also failed → logout handled elsewhere
        throw Exception("Session expired");
      }
    }

    return jsonDecode(response.body);
  }

  Future<dynamic> multipartRequest(
      String endpoint,
      Map<String, String> fields,
      List<XFile> images,
      ) async {
    final uri = Uri.parse(ApiConstants.baseUrl + endpoint);
    final request = http.MultipartRequest('POST', uri);

    // add token
    final token = await TokenStorage.getToken();
    if (token != null) {
      request.headers['Authorization'] = "Bearer $token";
    }

    // add fields
    request.fields.addAll(fields);

    // add images
    for (var image in images) {
      http.MultipartFile multipartFile;

      if (kIsWeb) {
        // Web: use bytes
        final bytes = await image.readAsBytes();
        multipartFile = http.MultipartFile.fromBytes(
          'images',
          bytes,
          filename: image.name,
        );
      } else {
        // Mobile/Desktop: use file path
        multipartFile = await http.MultipartFile.fromPath(
          'images',
          image.path,
        );
      }

      request.files.add(multipartFile);
    }

    final streamedResponse = await request.send();
    final responseString = await streamedResponse.stream.bytesToString();

    // return decoded JSON
    return jsonDecode(responseString);
  }
}