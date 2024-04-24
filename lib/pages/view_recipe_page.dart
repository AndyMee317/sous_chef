
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sous_chef/database/firestore.dart';

class ViewRecipePage extends StatefulWidget{
  ViewRecipePage ({super.key});

  @override
  State<ViewRecipePage> createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends State<ViewRecipePage> {
  String posterEmail = "aperson@email.com";
  String title = "Placeholder title";
  String instructions = "This is how you make this\n 1: you do this\n 2: you do that \n 3: you lastly do this";
  List<String> ingredients = ["A quart of something", "x tbs of another thing", "Lots of love <3"];
  List<String> tags = ["one", "two", "three", "four", "five"];

  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

  @override 

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(" By $posterEmail",
                    style: TextStyle(
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
              Text("Ingredients:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredients.length,
                
                itemBuilder: (BuildContext ctxt, int index){
                  return Center(child: Text("\u2022 " + ingredients[index]));
                }
              ),
              Text("Instructions:",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(instructions,
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              Text("Tags: ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredients.length,
                
                itemBuilder: (BuildContext ctxt, int index){
                  return Center(
                    child: GestureDetector(
                      child: Text("#" + ingredients[index])
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}