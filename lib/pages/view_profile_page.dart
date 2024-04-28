
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sous_chef/database/firestore.dart';

final FirestoreDatabase database = FirestoreDatabase();
class ViewProfilePage extends StatefulWidget{
  ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String,dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).get();
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("My Recipes"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        
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
                Navigator.pushNamed(context, "/home_page");
              }
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Recipes"),
              onTap: () {
                Navigator.pop(context);
              }
            ),

            ListTile(
              leading: Icon(Icons.logout),
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
        child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
          future: getUserDetails(),
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
              Map<String,dynamic>? user = snapshot.data!.data();
        
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(user!['username']),
                    Text(user!['email']),
                    StreamBuilder(
                      stream: database.searchRecipes(user!['email'], 'UserEmail'),
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
                              },
                              onLongPress: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete Recipe'),
                                      content: Text('Do you want to delete this recipe?'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text('Yes'),
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ).then((result) {
                                  if (result != null && result) {
                                    FirebaseFirestore.instance.collection('Recipes').doc(id).delete();
                                    setState(() {});
                                  } else {
                                    print('User clicked No');
                                  }
                                });
                              },
                            );
                          },
                        );
                      }
                    ),
                  ],
                ),
              );
            }
            else{
              return Text("Sorry, nothing");
            }
          }
        ),
      ),
    );
  }
}