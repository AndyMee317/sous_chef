
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MakeRecipePage extends StatelessWidget{

  const MakeRecipePage ({super.key});

  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

  @override 

  Widget build(BuildContext context){
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Make Recipe"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.filter_1 )),
              Tab(icon: Icon(Icons.filter_2)),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("Lorem ipsum"),
            ),
            Center(
              child: Text("Lorem ipsum2"),
            ),
          ],
        ),
      ),
    );
  }
}