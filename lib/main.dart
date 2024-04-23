
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:sous_chef/auth/auth.dart';
import 'package:sous_chef/auth/login_or_register.dart';
import 'package:sous_chef/pages/home_page.dart';
import 'package:sous_chef/pages/view_profile_page.dart';
import 'package:sous_chef/pages/make_recipe_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sous Chef',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(210, 255, 106, 0)),
        ),
        home: AuthPage(),
        routes: {
          "/login_or_register_page": (context) => const LoginOrRegister(),
          "/home_page": (context) => const HomePage(),
          "/view_profile_page": (context) => ViewProfilePage(),
          "/make_recipe_page": (context) => const MakeRecipePage()
        }
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
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sous chef'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Make Recipe'),
          onPressed: (){

          }
        ),
      ),
    );
  }
  
}

class MakeRecipe extends StatelessWidget{
  const MakeRecipe({super.key});

  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sous Chef'),
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
  const ViewRecipe({super.key});
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
