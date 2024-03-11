

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Sous Chef',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(0, 235, 97, 12)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final TextEditingController titleField = TextEditingController();
  final TextEditingController instructionsField = TextEditingController();
  final TextEditingController ingredientsField = TextEditingController();

  String title = '';
  String instructions = '';
  var ingredients = <String>[];
  var tags = <String>[];
  

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    titleField.dispose();
    instructionsField.dispose();
    ingredientsField.dispose();
    super.dispose();
  }

  void addIngredient(){
    if (!ingredients.contains(ingredientsField.text)){
      ingredients.add(ingredientsField.text);
      print("Added");
    }
    notifyListeners();
  }

  void removeIngredient(){
    if(ingredients.isNotEmpty){
      ingredients.removeLast();
      print("Removed");
    }
    notifyListeners();
  }

void submit(){
  title = titleField.text;
  instructions = instructionsField.text;
}

void clear(){
  title = '';
  instructions = '';
  ingredients.clear();
}

  @override
  void notifyListeners() {
    notifyListeners();
    
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  
  Widget build(BuildContext context){
    Widget page;
    switch(selectedIndex){
      case 0:
        page = MakeRecipe();
        break;
      case 1: 
        page = ViewRecipe();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

     return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Add Recipe'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.food_bank),
                      label: Text('View Recipe'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class MakeRecipe extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: appState.titleField,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'What do you call your dish?'
                  ),
                ),
            ),
            Text('Preparation instructions'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: appState.instructionsField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Explain how to prepare your recipe'
                ),
              ),
            ),
            Text('Ingredients'),
            TextField(
                  controller: appState.ingredientsField,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter ingredient and amount'
                  ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children:[
                ElevatedButton(
                  onPressed: (){
                    appState.addIngredient();
                  },
                  child: Text('Add'),
                ), 
                ElevatedButton(
                  onPressed: (){
                    appState.removeIngredient();
                  },
                  child: Text('Remove'),
                ),
              ],
            ),
            Expanded(
              child: 
                ListView.builder(
                  itemCount: appState.ingredients.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Text(
                      appState.ingredients[index],
                      key: UniqueKey()
                    );
                  },
                  
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: (){
                  appState.submit();
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewRecipe extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
     if (appState.title.isEmpty){
      return Center(
        child: Text('Sorry, nothing.'),
        );
    }

    return ListView(
      children: [
        
        Text(appState.title),
        Text('Ingredients'),
        for (var ingr in appState.ingredients)
          ListTile(
            leading: Icon(Icons.add),
            title: Text(ingr),
          ),
        Text('Preparation Instructions'),
        ListTile(
          leading: Icon(Icons.add),
          title: Text(appState.instructions),
        ),
        ElevatedButton(
          onPressed: (){
            appState.clear();
          },
           child: Text('Clear'),
        ),
      ],
    );
  }
}
