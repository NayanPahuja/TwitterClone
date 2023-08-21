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
  FutureEither<models.Session> login({
    required String email,
    required String password,
  });
  Future<models.User?> currentUserAccount();
}


class AuthAPI implements IAuthAPI{
  @override
  Future<models.User?> currentUserAccount() async{
    // TODO: implement currentUserAccount
    try{
      return _account.get();
    } on AppwriteException catch(e){
      return null;
    }
    catch(e){
      return null;
    }

  }



  final Account _account; //class has private variable to make instance of User class
  AuthAPI({required Account account}): _account = account; //constructor
  @override
  FutureEither<models.User> signUp({required String email, required String password})
  async{
    try{
      final account = await _account.create(userId: ID.unique(), email: email, password: password);
      return Right(account);
    } on AppwriteException catch(e,stackTrace ){
      return Left(Failure(e.message??'Some unexpected error occurred', stackTrace.toString()));
    } on Exception


    catch(e, stackTrace){
      return Left(Failure(e.toString(), stackTrace.toString()));
    }

  }

  @override
  FutureEither<models.Session> login({required String email, required String password}) async{

    try{
      final session = await _account.createEmailSession(email: email, password: password);
      return Right(session);

    }
    on AppwriteException catch(e, stackTrace){
      return Left(Failure(e.message??'Some unexpected error occurred', stackTrace.toString()));
    }
    catch(e,stackTrace){
      return Left(Failure(e.toString(), stackTrace.toString()));
    }

  }



}
