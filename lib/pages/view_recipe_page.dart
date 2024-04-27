
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewRecipePage extends StatefulWidget{
  ViewRecipePage ({super.key});

  @override
  State<ViewRecipePage> createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends State<ViewRecipePage> {

  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

  @override 

  Widget build(BuildContext context){
  final String? id = ModalRoute.of(context)!.settings.arguments as String?;
  Future<DocumentSnapshot<Map<String,dynamic>>> getRecipeDetails() async {
    return await FirebaseFirestore.instance.collection("Recipes").doc(id).get();
  }

    return Scaffold(
      appBar: AppBar(
        title: Text('View Recipe'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: getRecipeDetails(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError){
            return Text("An error has occured: ${snapshot.error}");
          }
          else if (snapshot.hasData){
            Map<String,dynamic>? recipe = snapshot.data!.data();

            return Column(
              children:[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(recipe!['title'],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(" By ${recipe['UserEmail']}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                      recipe!['imageURL'] != "" ?
                      Image(
                        image: NetworkImage(recipe!['imageURL']),
                        width: 550,
                        height: 300,
                      )
                      :
                      Image(
                        image: NetworkImage('https://cdn3.iconfinder.com/data/icons/design-n-code/100/272127c4-8d19-4bd3-bd22-2b75ce94ccb4-512.png'),
                        width: 350,
                        height: 300,
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
                        itemCount: recipe['ingredients'].length,
                        
                        itemBuilder: (BuildContext ctxt, int index){
                          return Center(child: Text("\u2022 " + recipe['ingredients'][index]));
                        }
                      ),
                      Text("Instructions:",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(recipe['instructions'],
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
                        itemCount: recipe['tags'].length,
                        
                        itemBuilder: (BuildContext ctxt, int index){
                          return Center(
                            child: GestureDetector(
                              child: Text("#" + recipe['tags'][index])
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          else{
            return Text("Sorry, nothing");
          }
        },
      ),
    );
  }
}