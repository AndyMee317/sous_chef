
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sous_chef/auth/login_or_register.dart';
import 'package:sous_chef/pages/home_page.dart';
class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const HomePage();
          }
          else{
            return const LoginOrRegister();
          }
        }
      ),
    );
  }
}