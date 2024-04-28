
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sous_chef/database/firestore.dart';

class ViewProfilePage extends StatelessWidget{
  ViewProfilePage({super.key});

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
        title: Text("My profile"),
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
              title: Text("My Profile"),
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
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
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
                  ElevatedButton(
                    onPressed: (){

                    }, 
                    child: Text('View My Recipes'),
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
    );
  }
}