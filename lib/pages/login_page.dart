
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
            Text('Login'),
            Padding(
              padding: const EdgeInsets.all(20.0),
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
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passwordField,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder()
                ),
              ),
            ),

            // TODO: implement "forgor password function"
            
            ElevatedButton(
              child: Text('Submit'),
              onPressed: (){

              }
            ),
          ],
        ),
      ),
    );

  }
}