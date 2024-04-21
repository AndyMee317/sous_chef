
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{

  final void Function()? onTap;

  LoginPage({super.key, required this.onTap()});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailField = TextEditingController();

  final TextEditingController passwordField = TextEditingController();

  // todo: add login function
  void login () async{
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailField.text, password: passwordField.text);
      if (context.mounted) Navigator.pop(context);
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

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Sous chef'),
      ),
      body:Center(
        child: Column(
          children: [
            Icon(
              Icons.kitchen_outlined,
              size: 80,
            ),
            const SizedBox(
              height: 30,
            ),
            Text('Welcome Back!'),
            Padding(
              padding: const EdgeInsets.all(15.0),
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
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: passwordField,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder()
                ),
              ),
            ),

            GestureDetector(
              onTap: (){},
              child: Text("Forgot Password", 
                style: TextStyle(color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Login'),
                onPressed: login,
              ),
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Text("New? Sign up here", 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}