
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget{
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final TextEditingController emailField = TextEditingController();

  Future resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailField.text.trim());
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text("Recovery email sent"),
          );
        },
      );
    } on FirebaseAuthException catch (e){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  @override 

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Recover'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailField,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'enter recovery email',
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: resetPassword, 
                child: Text('Send Reset Request')
              ),
            ),
          ],
        ),
      ),
    );
  }
}