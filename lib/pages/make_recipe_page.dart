
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MakeRecipePage extends StatefulWidget{

  const MakeRecipePage ({super.key});

  @override
  State<MakeRecipePage> createState() => _MakeRecipePageState();
}

class _MakeRecipePageState extends State<MakeRecipePage> {

  final TextEditingController titleField = TextEditingController();

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
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Title'),
                  Padding(
                    padding: EdgeInsets.all(26.0),
                    child: TextField(
                        controller: titleField,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'What do you call your dish?'
                        ),
                      ),
                  ),
                ],
              ),
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