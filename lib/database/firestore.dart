
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference recipes = FirebaseFirestore.instance.collection("Recipes");

  Future<void> postRecipe(String title, String instructions, List<String> ingredients, List<String>tags) {
    return recipes.add({
      "UserEmail": user!.email,
      "title": title,
      "instructions" : instructions,
      "ingredients" : ingredients,
      "tags" : tags,
      "timestamp": Timestamp.now(),
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
}