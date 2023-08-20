import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:appwrite/appwrite.dart';

import '../core/providers.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI(
      account: ref.watch(appwriteAccountProvider
      ));
});



abstract class IAuthAPI{
  FutureEither<models.User> signUp({
    required String email,
    required String password,
});

}


class AuthAPI implements IAuthAPI{
  final Account _account; //class has private variable to make instance of User class
  AuthAPI({required Account account}): _account = account; //constructor
  @override
  FutureEither<models.User> signUp({required String email, required String password})
  async{
    try{
      final account = await _account.create(userId: ID.unique(), email: email, password: password);
      return Right(account);
    } on AppwriteException catch(e, stackTrace){
      return Left(Failure(e.message??'Some unexpected error occurred', stackTrace as String));
    } on Exception


    catch(e, stackTrace){
      return Left(Failure(e.toString(), stackTrace as String));
    }

  }

}
