
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sous_chef/database/firestore.dart';

final FirestoreDatabase database = FirestoreDatabase();


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Home!"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed:(){
              Navigator.pushNamed(context, '/search_bar_page');
            }
          ),
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
          child: Column(
          children: [
            DrawerHeader(
              child: Icon(Icons.kitchen)
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              }
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Profile"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/view_profile_page");
              }
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                logout();
              }
            ),
          ],
        )
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.bottomCenter,
      
            child: SingleChildScrollView(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: database.getRecipes(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
            
                      final recipes = snapshot.data!.docs;
            
                      if(snapshot.data == null || recipes.isEmpty){
                        return Center(
                          child: Text("No recipes found")
                        );
                      }
            
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
          
                          final recipe = recipes[index];
                          String title = recipe['title'];
                          String posterEmail = recipe['UserEmail'];
                          String id = recipe.id;
                          Timestamp timestamp = recipe['timestamp'];
          
                          return ListTile(
                            title: Text(title),
                            subtitle: Text('by $posterEmail'),
                            onTap: (){
                              Navigator.pushNamed(context, '/view_recipe_page', arguments: id);
                            }
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/make_recipe_page');
        },
        tooltip: 'Make recipe',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}