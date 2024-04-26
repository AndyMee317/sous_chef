
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sous_chef/database/firestore.dart';

final FirestoreDatabase database = FirestoreDatabase();
class SearchResultsPage extends StatefulWidget{
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override 

  Widget build(BuildContext context){    
    final List<String> args = ModalRoute.of(context)!.settings.arguments as List<String>;
    final String searchQuery = args[0];
    final String searchType = args[1];

    void logout() {
      FirebaseAuth.instance.signOut(); 
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for " + searchQuery),
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
                Navigator.pushNamed(context, '/home_page');
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(searchType),
            StreamBuilder(
              stream: database.searchRecipes(searchQuery, searchType),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final recipes = snapshot.data!.docs;

                if(snapshot.data == null || recipes.isEmpty){
                  return Center(
                    child: Text("No results found")
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
              }
            ),
          ],
        ),
      ),
    );
  }
}