import 'package:flutter/cupertino.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/models/user_model.dart';

import '../../../apis/auth_api.dart';
import '../view/login_view.dart';

final authControllerProvider = StateNotifierProvider<AuthController,bool >((ref) {

  return AuthController(AuthAPI: ref.watch(authAPIProvider), userAPI: ref.watch(userAPIProvider));
  
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final userDetails =  ref.watch(userDetailsProvider()).currentUser();
  return user;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) async {
  final user = await ref.watch(authControllerProvider.notifier);
  return user.getUserData(uid);

});

//future provider
final currentUserAccountProvider = FutureProvider<models.User?>((ref) async{
  final user = await ref.watch(authControllerProvider.notifier).currentUser();
  return user;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _AuthAPI;
  final userAPI _userAPI;
  AuthController({required AuthAPI AuthAPI, required userAPI userAPI}): _AuthAPI = AuthAPI, _userAPI = userAPI, super(false);
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
    response.fold((l) => showSnackBar(context, l.message), (r) async{
      UserModel userModel = UserModel(
          email: email,
          name: getInitials(email),
          uid: '',
          profilePic: '',
          bio: '',
          bannerPic: '',
          followers: const [],
          following: const [],
          isTwitterBlue: false
      );
      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Account Created Successfully, Please Login');
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
      });
  });
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

  Future<UserModel> getUserData(String uid, ) async{
    final document = await _userAPI.getUserData(uid);
    final updatedUser =  UserModel.fromMap(document.data);
    return
      updatedUser;

  }

}
