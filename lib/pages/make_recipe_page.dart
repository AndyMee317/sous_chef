
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sous_chef/database/firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sous_chef/utils.dart';
import 'dart:typed_data';

class MakeRecipePage extends StatefulWidget{

  const MakeRecipePage ({super.key});
  

  @override
  State<MakeRecipePage> createState() => _MakeRecipePageState();
}

class _MakeRecipePageState extends State<MakeRecipePage> {

  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController titleField = TextEditingController();
  final TextEditingController instructionsField = TextEditingController();
  final TextEditingController ingredientsField = TextEditingController();
  final TextEditingController tagsField = TextEditingController();

  List<String> ingredients = [];
  List<String> tags = [];
  Uint8List? _image;

  void logout() {
    FirebaseAuth.instance.signOut(); 
  }

    void selectImage()async{
      Uint8List img = await pickImage(ImageSource.gallery);
      setState((){
        _image = img;
      });
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

  void addTag(){

    if(tagsField.text.isEmpty){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Please enter something in the field")
          )
        );
    }

    if(!tags.contains(tagsField.text)){
      tags.add(tagsField.text);
      tagsField.clear();
      setState((){});
    }
    else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Tag already added")
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

  void removeTag(){
    if(tags.isNotEmpty){
      tags.removeLast();
      setState((){});
    }
  }

  void submit(){
    
    if(titleField.text.isEmpty || instructionsField.text.isEmpty || ingredients.isEmpty || tags.isEmpty){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Please make sure your recipe has a title, instructions, at least one ingredient, and at least one tag")
        )
      );
    }
    else{
      database.postRecipe(titleField.text, instructionsField.text, ingredients, tags);
      Navigator.pop(context);
    }
  }

  @override 


  Widget build(BuildContext context){
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
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
              Tab(icon: Icon(Icons.filter_5)),
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
                    Expanded(
                    child: ListView.builder(
                      itemCount: ingredients.length,
                      itemBuilder: (BuildContext ctxt, int Index){
                        return Text("\u2022 ${ingredients[Index]}");
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
                  Text("4. Tags"),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: TextField(
                      controller: tagsField,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter relavant tags for this recipe (eg ingredients, meal type)'
                      ),
                      onSubmitted: (text){
                        addTag();
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      ElevatedButton(
                        onPressed: (){
                          addTag();
                        },
                        child: Text('Add'),
                      ), 
                      ElevatedButton(
                        onPressed: (){
                          removeTag();
                        },
                        child: Text('Remove'),
                      ),
                      ],
                    ),
                    Expanded(
                    child: ListView.builder(
                      itemCount: tags.length,
                      itemBuilder: (BuildContext ctxt, int Index){
                        return Text("#${tags[Index]}");
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
                  Text("5. Upload dish image "),

                  _image != null ? 
                    Image(
                      image: MemoryImage(_image!),
                      width: 350,
                      height: 300,
                    )
                  :
                  Image(
                    image: NetworkImage('https://cdn3.iconfinder.com/data/icons/design-n-code/100/272127c4-8d19-4bd3-bd22-2b75ce94ccb4-512.png'),
                    width: 350,
                    height: 300,
                  ),

                  ElevatedButton(
                    onPressed: selectImage,
                    child: Text('Select Image'),
                  )
                  
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            submit();
          },
          tooltip: 'submit',
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}