import 'package:flutter/cupertino.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';

import '../../../apis/auth_api.dart';
import '../view/login_view.dart';

final authControllerProvider = StateNotifierProvider<AuthController,bool >((ref) {

  return AuthController(AuthAPI: ref.watch(authAPIProvider));
  
});


class AuthController extends StateNotifier<bool> {
  final AuthAPI _AuthAPI;
  AuthController({required AuthAPI AuthAPI}): _AuthAPI = AuthAPI, super(false);
  //isloading

  Future<models.User?> currentUser() => _AuthAPI.currentUserAccount();




  void signUp({
    required String email,
    required String password,
    required BuildContext context
})
  async {
    state: true;
    //call api
    final response = await _AuthAPI.signUp(email: email, password: password);
    state = false;
    response.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Account Created Successfully, Please Login');
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
    } );
  }
  void login({
    required String email,
    required String password,
    required BuildContext context
}) async{
    //call api
    state: true;
    final response = await _AuthAPI.login(email: email, password: password);
    state = false;
    response.fold((l) => showSnackBar(context,l.message), (r){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
    });

  }


}
