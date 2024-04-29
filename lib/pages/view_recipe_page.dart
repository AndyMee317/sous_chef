
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewRecipePage extends StatefulWidget{
  ViewRecipePage ({super.key});

  @override
  State<ViewRecipePage> createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends State<ViewRecipePage> {

  User? user = FirebaseAuth.instance.currentUser;
  bool recipeIsLiked = false;
  bool recipeIsDisliked = false;

  void logout() {
    FirebaseAuth.instance.signOut(); 
  }


  @override 

  Widget build(BuildContext context){
  final String? id = ModalRoute.of(context)!.settings.arguments as String?;
  Future<DocumentSnapshot<Map<String,dynamic>>> getRecipeDetails() async {
    return await FirebaseFirestore.instance.collection("Recipes").doc(id).get();
  }

  void likeToggle(){
    setState(() {
      recipeIsLiked = !recipeIsLiked;
    });

    DocumentReference thisRecipe = FirebaseFirestore.instance.collection('Recipes').doc(id);
    if(recipeIsLiked && recipeIsDisliked){
      recipeIsDisliked = !recipeIsDisliked;
      thisRecipe.update({
        'likes' : FieldValue.arrayUnion([user!.email]),
        'dislikes' : FieldValue.arrayRemove([user!.email])
      });
    }
    else if(recipeIsLiked){
      thisRecipe.update({
        'likes' : FieldValue.arrayUnion([user!.email]),
      });
    }
    else{
      thisRecipe.update({
        'likes' : FieldValue.arrayRemove([user!.email])
      });
    }
  }

  void dislikeToggle(){
    setState(() {
      recipeIsDisliked = !recipeIsDisliked;
    });

    DocumentReference thisRecipe = FirebaseFirestore.instance.collection('Recipes').doc(id);
    if(recipeIsDisliked && recipeIsLiked){
      recipeIsLiked = !recipeIsLiked;
      thisRecipe.update({
        'likes' : FieldValue.arrayRemove([user!.email]),
        'dislikes' : FieldValue.arrayUnion([user!.email])
      });
    }
    else if(recipeIsDisliked){
      thisRecipe.update({
        'dislikes' : FieldValue.arrayUnion([user!.email]),
      });
    }
    else{
      thisRecipe.update({
        'dislikes' : FieldValue.arrayRemove([user!.email])
      });
    }
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
            final recipe = snapshot.data!.data();

            List<dynamic> userLikes = recipe!['likes'] ?? [];
            if (userLikes.contains(user!.email)){
              recipeIsLiked = true;
            }

            List<dynamic> userDislikes = recipe['dislikes'] ?? [];
            if (userDislikes.contains(user!.email)){
              recipeIsDisliked = true;
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(recipe['title'],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        GestureDetector(
                          child: Text(" By ${recipe['UserEmail']}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          onTap:(){
                            String userEmail = recipe['UserEmail'];
                            Navigator.pushNamed(context, '/search_results_page', arguments: [userEmail, 'UserEmail']);
                          }
                        ),
                      ],
                    ),
                    recipe['imageURL'] != "" ?
                    Image(
                      image: NetworkImage(recipe['imageURL']),
                      width: 550,
                      height: 300,
                    )
                    :
                    Image(
                      image: NetworkImage('https://cdn3.iconfinder.com/data/icons/design-n-code/100/272127c4-8d19-4bd3-bd22-2b75ce94ccb4-512.png'),
                      width: 350,
                      height: 300,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Like(liked: recipeIsLiked, onTap: likeToggle),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${userLikes.length - userDislikes.length}'),
                        ),
                        Dislike(disliked: recipeIsDisliked, onTap: dislikeToggle)
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
                        String tag = recipe['tags'][index];
                        return Center(
                          child: GestureDetector(
                            child: Text("#" + recipe['tags'][index]),
                            onTap:(){
                              Navigator.pushNamed(
                                context, '/search_results_page',
                                arguments: [tag,'tags'],
                              );
                            }
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
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

class Like extends StatelessWidget{
  final bool liked;
  void Function()? onTap;
  Like({super.key, required this.liked, required this.onTap});

  @override 
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        liked ? Icons.thumb_up: Icons.thumb_up_outlined
      ),
    );
  }
}

class Dislike extends StatelessWidget{
  final bool disliked ;
  void Function()? onTap;
  Dislike({super.key, required this.disliked, required this.onTap});

  @override 
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        disliked ? Icons.thumb_down: Icons.thumb_down_outlined
      ),
    );
  }
}