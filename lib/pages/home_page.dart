
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<String> searchType = <String> ['tags', 'title'];
String currentSearchType = 'tags';

final TextEditingController searchField = TextEditingController();

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
              title: Text("Test View Recipe"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/view_recipe_page");
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: 55,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                              controller: searchField,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Search'
                              ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: DropdownButton(
                        value: currentSearchType,
                        hint: Text("Search By..."),
                        icon: const Icon(Icons.arrow_downward),
                        items: searchType.map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(), 
                        onChanged: (String? value){
                          setState((){
                            currentSearchType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                
              ],
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