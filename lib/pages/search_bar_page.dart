
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const List<String> searchType = <String> ['tags', 'title','UserEmail'];
String currentSearchType = 'tags';
final TextEditingController searchField = TextEditingController();

class SearchBarPage extends StatefulWidget{
  const SearchBarPage ({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  void logout() {
    FirebaseAuth.instance.signOut(); 
  }
  @override 

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
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
                Navigator.pushNamed(context, '/home_page');
              }
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Recipes"),
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
          ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/search_results_page',
                    arguments: [searchField.text, currentSearchType]
                  );
                },
                icon: Icon(Icons.search),
                label: Text('Search'),
              ),
        ],
      ),
    );
  }
}