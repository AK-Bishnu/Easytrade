import '../../../core/network/api_client.dart';


class AuthRepository {

  final ApiClient api;

  AuthRepository(this.api);

  Future<Map<String, String>> login({
    required String email,
    required String password,
  }) async {

    final response = await api.post(
      "login/",
      {
        "email": email,
        "password": password,
      },
    );

    return {
      "access": response["access"],
      "refresh": response["refresh"],
    };
  }

  Future<Map<String, dynamic>> signup({
    required String username,
    required String email,
    required String password,
    String? whatsapp,
    String? telegram,
    String? facebook,
  }) async {

   final res = await api.post(
      "signup/",
      {
        "username": username,
        "email": email,
        "password": password,
        "whatsapp": whatsapp,
        "telegram": telegram,
        "facebook": facebook,
      },
    );
   return res;
  }


  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final res = await api.post("forgot-password/", {"email": email});
    return res;
  }

  Future<bool> checkVerification(int userId, String token) async{
    final res = await api.get("check-reset-verification/$userId/$token/");
    return res['success'];
  }

  Future<Map<String, dynamic>> resetPassword(
      int userId, String token, String newPassword) async {
    final res = await api.post(
      "reset-password/$userId/$token/submit/",
      {"password": newPassword},
    );
    return res;
  }
  

}