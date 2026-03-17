import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../home/products/presentation/product_provider.dart';
import '../data/profile_model.dart';
import '../data/profile_repository.dart';


final profileRepoProvider = Provider((ref) {
  return ProfileRepository(ref.read(apiClientProvider));
});

final profileProvider =
StateNotifierProvider<ProfileController, AsyncValue<UserProfile?>>((ref) {

  return ProfileController(ref.read(profileRepoProvider));
});

class ProfileController extends StateNotifier<AsyncValue<UserProfile?>> {

  final ProfileRepository repo;

  ProfileController(this.repo) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final profile = await repo.getProfile();
      state = AsyncValue.data(profile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateProfile({
    String? whatsapp,
    String? telegram,
    String? facebook,
  }) async {

    try {
      final updated = await repo.updateProfile(
        whatsapp: whatsapp,
        telegram: telegram,
        facebook: facebook,
      );

      state = AsyncValue.data(updated);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}