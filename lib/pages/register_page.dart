
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{

  final void Function()? onTap;

  

  RegisterPage({super.key, required this.onTap()});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameField = TextEditingController();
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  final TextEditingController confirmField = TextEditingController();

  void register() async{
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if(passwordField.text !=  confirmField.text){
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Your passwords must match")
        )
      );
    }

    else{
      try{
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailField.text, 
          password: passwordField.text,
        );

        createUserDocument(userCredential);

        Navigator.pop(context);
      } on FirebaseAuthException catch (e){
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.code)
          )
        );
      }
    }
  }

 Future<void> createUserDocument(UserCredential? userCredential) async {
  if (userCredential != null && userCredential.user != null){
    await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
      'email': userCredential.user!.email,
      'username': usernameField.text,
  });
  }
 }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Sous chef'),
      ),
      body:Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
              ),
              const SizedBox(
                height: 30,
              ),
          
              Text('Sign up'),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: usernameField,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailField,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: confirmField,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: register,
                  child: Text('Register')
                ),
              ),
          
              GestureDetector(
                onTap: widget.onTap,
                child: Text("Already a chef? Login Here", 
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
          
            ],
          ),
        ),
      ),
    );

  }
}