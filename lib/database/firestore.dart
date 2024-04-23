
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference recipes = FirebaseFirestore.instance.collection("Recipes");

  Future<void> postRecipe(String title, String instructions, List<String> ingredients) {
    return recipes.add({
      "UserEmail": user!.email,
      "title": title,
      "instructions" : instructions,
      "ingredients" : ingredients,
      "timestamp": Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getRecipes(){
    final recipeStream = FirebaseFirestore.instance.collection('Recipes').orderBy('timestamp', descending: true).snapshots();
    return recipeStream;
  }
}