import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/auth_api.dart';

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
    //#TODO: handle response
    response.fold((l) => null, (r) => null);
  }
}
