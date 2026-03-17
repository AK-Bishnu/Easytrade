import 'package:easytrade_web/features/profile/data/profile_model.dart';
import '../../../core/network/api_client.dart';


class ProfileRepository {

  final ApiClient api;

  ProfileRepository(this.api);

  Future<UserProfile> getProfile() async {

    final res = await api.get("profile/");

    return UserProfile.fromJson(res);
  }

  Future<UserProfile> updateProfile({
    String? whatsapp,
    String? telegram,
    String? facebook,
  }) async {

    final res = await api.put(
      "profile/update/",
      {
        "whatsapp": whatsapp,
        "telegram": telegram,
        "facebook": facebook,
      },
    );

    return UserProfile.fromJson(res);
  }
}