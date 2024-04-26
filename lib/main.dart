
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// pages
import 'package:sous_chef/auth/auth.dart';
import 'package:sous_chef/auth/login_or_register.dart';
import 'package:sous_chef/pages/home_page.dart';
import 'package:sous_chef/pages/view_profile_page.dart';
import 'package:sous_chef/pages/make_recipe_page.dart';
import 'package:sous_chef/pages/view_recipe_page.dart';
import 'package:sous_chef/pages/search_bar_page.dart';
import 'package:sous_chef/pages/search_results_page.dart';

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
          "/make_recipe_page": (context) => const MakeRecipePage(),
          "/view_recipe_page": (context) => ViewRecipePage(),
          "/search_bar_page": (context) => const SearchBarPage(),
          "/search_results_page": (context) => const SearchResultsPage(),
        }
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {

  @override
  void notifyListeners() {
    notifyListeners();
    
  }
}

