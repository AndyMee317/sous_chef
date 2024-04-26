
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sous_chef/database/firestore.dart';

class SearchResultsPage extends StatelessWidget{
  const SearchResultsPage({super.key});

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
      body: Column(
        children: [
          Text(searchQuery),
          Text(searchType),
        ],
      ),
    );
  }

}