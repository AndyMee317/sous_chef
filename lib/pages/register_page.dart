
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget{

  final void Function()? onTap;

  // todo: add login function
  
  // todo: add sign up function

  RegisterPage({super.key, required this.onTap()});

  final TextEditingController usernameField = TextEditingController();
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  final TextEditingController confirmField = TextEditingController();
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Sous chef'),
      ),
      body:Center(
        child: Column(
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
              padding: const EdgeInsets.all(15.0),
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

            Padding(
              padding: const EdgeInsets.all(15.0),
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
                child: Text('Register'),
                onPressed: (){
              
                }
              ),
            ),

            GestureDetector(
              onTap: (){},
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
    );

  }
}