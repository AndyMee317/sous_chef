
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MakeRecipePage extends StatefulWidget{

  const MakeRecipePage ({super.key});

  @override
  State<MakeRecipePage> createState() => _MakeRecipePageState();
}

class _MakeRecipePageState extends State<MakeRecipePage> {

  final TextEditingController titleField = TextEditingController();
  final TextEditingController instructionsField = TextEditingController();
  final TextEditingController ingredientsField = new TextEditingController();

  List<String> ingredients = [];
  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

  void addIngredient(){

    if(ingredientsField.text.isEmpty){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Please enter something in the field")
          )
        );
    }

    if(!ingredients.contains(ingredientsField.text)){
      ingredients.add(ingredientsField.text);
      ingredientsField.clear();
      setState((){});
    }
    else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Ingredient already added")
        )
      );
    }
  }

  void removeIngredient(){
    if(ingredients.isNotEmpty){
      ingredients.removeLast();
      setState((){});
    }
  }

  @override 


  Widget build(BuildContext context){
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
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
              Tab(icon: Icon(Icons.filter_3)),
              Tab(icon: Icon(Icons.filter_4)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('1. Title'),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('2. Preparation instructions'),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: SizedBox(
                      child: TextField(
                        controller: instructionsField,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Explain how to prepare your recipe',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text("3. List of ingredients"),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: TextField(
                      controller: ingredientsField,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter ingredient and amount'
                      ),
                      onSubmitted: (text){
                        addIngredient();
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      ElevatedButton(
                        onPressed: (){
                          addIngredient();
                        },
                        child: Text('Add'),
                      ), 
                      ElevatedButton(
                        onPressed: (){
                          removeIngredient();
                        },
                        child: Text('Remove'),
                      ),
                      ],
                    ),
                  new Expanded(
                    child: new ListView.builder(
                      itemCount: ingredients.length,
                      itemBuilder: (BuildContext ctxt, int Index){
                        return new Text("\u2022 " + ingredients[Index]);
                      }
                    ) 
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Images coming soon")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}