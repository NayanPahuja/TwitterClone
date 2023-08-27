


import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/models/user_model.dart';


final userAPIProvider = Provider((ref)
{
  return userAPI(database: ref.watch(appwriteDatabaseProvider));
});


abstract class IUserAPI{
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);

}

class userAPI implements IUserAPI{
  final Databases _database;
  userAPI({required Databases database}): _database = database;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try{
      await _database.createDocument(databaseId: AppwriteConstants.databaseID, collectionId: AppwriteConstants.userCollectionId, documentId: ID.unique(), data: userModel.toMap());
    return Right(null);
    }

    on AppwriteException catch(e,st){
      return Left(Failure(e.message??'Some unexpected error occurred', st.toString()));
    }
    catch(e,st){
      return Left(Failure(e.toString(), st.toString()));

    }
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _database.getDocument(databaseId: AppwriteConstants.databaseID, collectionId: AppwriteConstants.userCollectionId, documentId: uid);
  }

}