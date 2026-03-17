import 'dart:convert';
import 'package:easytrade_web/core/storage/token_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

Future<bool> refreshAccessToken() async {
  final refresh = await TokenStorage.getRefreshToken();

  if (refresh == null) {
    print("NO REFRESH TOKEN");
    return false;
  }

  try {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}token/refresh/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refresh": refresh}),
    );

    print("REFRESH STATUS: ${response.statusCode}");
    print("REFRESH BODY: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await TokenStorage.saveToken(data["access"]);
      print("REFRESH SUCCESS ✅");
      return true;
    }

    // invalid refresh token
    await TokenStorage.clearTokens();
    return false;
  } catch (e) {
    print("REFRESH ERROR: $e");
    return false;
  }
}