
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget{

  final void Function()? onTap;

  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  // todo: add login function
  
  // todo: add sign up function

  // todo: add forgot password function

  LoginPage({super.key, required this.onTap()});
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
                onPressed: (){
              
                }
              ),
            ),
            GestureDetector(
              onTap: onTap,
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