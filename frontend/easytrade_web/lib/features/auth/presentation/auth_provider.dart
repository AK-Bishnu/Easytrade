import 'package:easytrade_web/core/storage/token_storage.dart';
import 'package:easytrade_web/features/auth/data/auth_repository.dart';
import 'package:easytrade_web/features/home/products/presentation/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepository(ref.read(apiClientProvider));
},);

final authProvider = StateNotifierProvider<AuthController,bool>((ref) {
  return AuthController(ref.read(authRepoProvider));
},);



class AuthController extends StateNotifier<bool> {

  final AuthRepository repo;
  AuthController(this.repo) : super(false);

  Future<void> login(String email, String password) async {
    final tokens = await repo.login(email: email, password: password);

    await TokenStorage.saveToken(tokens["access"]!);
    await TokenStorage.saveRefreshToken(tokens["refresh"]!);


    state = true;
  }

  Future<Map<String, dynamic>>signup(
      String username,
      String email,
      String password,
      String? whatsapp,
      String? telegram,
      String? facebook,
      ) async {

    final res = await repo.signup(
      username: username,
      email: email,
      password: password,
      whatsapp: whatsapp,
      telegram: telegram,
      facebook: facebook,
    );

    return res;
  }


  Future<void> logout() async {

    await TokenStorage.clearTokens();
    state = false;
  }


  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final res = await repo.forgotPassword(email);
    return res;
  }

  Future<bool> checkVerifiedSuccess(int userId, String token) async{
    final res = await repo.checkVerification(userId, token);
    return res;
  }

  Future<Map<String, dynamic>> resetPassword(
      int userId, String token, String newPassword) async {
    final res = await repo.resetPassword(userId, token, newPassword);
    return res;
  }


}