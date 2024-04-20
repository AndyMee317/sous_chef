
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget{
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();

  LoginPage({super.key});
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
            Text("Forgot Password", 
              style: TextStyle(color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              )
            ),
            // TODO: implement "forgor password function"

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Login'),
                onPressed: (){
              
                }
              ),
            ),
            Text("New? Sign up here", 
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              )
            ),
          ],
        ),
      ),
    );

  }
}