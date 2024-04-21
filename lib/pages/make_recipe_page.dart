
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MakeRecipePage extends StatelessWidget{

  const MakeRecipePage ({super.key});

  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

  @override 

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Make Recipe"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}