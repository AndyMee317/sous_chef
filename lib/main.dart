import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sous Chef',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyAppState extends ChangeNotifier {


}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  
  Widget build(BuildContext context){
    Widget page;
    switch(selectedIndex){
      case 0:
        page = PlaceHolder();
        break;
      case 1: 
        page = PlaceHolder2();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

     return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.food_bank),
                      label: Text('Add Recipe'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class PlaceHolder extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    // var appState = context.watch<MyAppState>();
    return Center(
      child: Text('Page1')
    );
  }
}

class PlaceHolder2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    // var appState = context.watch<MyAppState>();
    return Center(
      child: Text('Page2')
    );
  }
}
