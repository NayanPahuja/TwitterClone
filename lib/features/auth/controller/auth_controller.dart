import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/core.dart';

import '../../../apis/auth_api.dart';

final authControllerProvider = StateNotifierProvider<AuthController,bool >((ref) {

  return AuthController(AuthAPI: ref.watch(authAPIProvider));
  
});


class AuthController extends StateNotifier<bool> {
  final AuthAPI _AuthAPI;
  AuthController({required AuthAPI AuthAPI}): _AuthAPI = AuthAPI, super(false);
  //isloading


  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context
})
  async {
    state: true;
    //call api
    final response = await _AuthAPI.signUp(email: email, password: password);
    state = false;
    response.fold((l) => showSnackBar(context, l.message), (r) => print(r.email));
  }

}
