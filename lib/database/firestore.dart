
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference recipes = FirebaseFirestore.instance.collection("Recipes");

  Future<void> postRecipe(String title, String instructions, List<String> ingredients, List<String>tags, String imageURL) {
    return recipes.add({
      "UserEmail": user!.email,
      "title": title,
      "instructions" : instructions,
      "ingredients" : ingredients,
      "tags" : tags,
      "timestamp": Timestamp.now(),
      "imageURL": imageURL,
      "likes": [],
    });
  }

  Stream<QuerySnapshot> getRecipes(){
    final recipeStream = FirebaseFirestore.instance.collection('Recipes').orderBy('timestamp', descending: true).snapshots();
    return recipeStream;
  }

  Stream<QuerySnapshot> searchRecipesTitle(String query){
    final searchResultStream = FirebaseFirestore.instance.collection('Recipes').where('title', isEqualTo: query).snapshots();
    return searchResultStream; 
  }

  Stream<QuerySnapshot> searchRecipesTags(String query){
    final searchResultStream = FirebaseFirestore.instance.collection('Recipes').where('tags', arrayContains: query).snapshots();
    return searchResultStream; 
  }

  Stream<QuerySnapshot> searchRecipes(String query, String type){
    if (type == 'title'){
      final searchResultStream = FirebaseFirestore.instance.collection('Recipes').orderBy('timestamp').where('title', isEqualTo: query).snapshots();
      return searchResultStream;
    }
    else if(type == 'tags'){
      final searchResultStream = FirebaseFirestore.instance.collection('Recipes').orderBy('timestamp').where('tags', arrayContains: query).snapshots();
      return searchResultStream;
    }
    else if(type == 'UserEmail'){
      final searchResultsStream = FirebaseFirestore.instance.collection('Recipes').orderBy('timestamp').where('UserEmail', isEqualTo: query).snapshots();
      return searchResultsStream;
    }
    
    // this shouldn't happen, but in case something weird happens, just return everything
    final recipeStream = FirebaseFirestore.instance.collection('Recipes').orderBy('timestamp', descending: true).snapshots();
    return recipeStream;
  }
}