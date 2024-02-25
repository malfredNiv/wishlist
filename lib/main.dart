import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishlist',
      theme: ThemeData(
        fontFamily: 'Roboto-Bold',
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 157, 140, 231)),
        useMaterial3: true,
      ),
      
      home: const MyHomePage(title: 'Makes your wish comme true'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 157, 140, 231),
      ),
      drawer: Drawer(
       
        child: ListView(
          // Important: Remove any padding from the ListView.
          children: [
            Container(
              height: 70,
              child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 157, 140, 231),
              ),
              child: Text('Wishlist menu'),
              padding: EdgeInsets.all(20.0), // Adjust the padding as needed

              //thin the 
            ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: const Text('Create a wish'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.remove_red_eye_outlined),
              title: const Text('View your wish'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ' ${_counter == 1 ? 'There\'s only $_counter wish, add another one ! ' : _counter > 1 ? 'There are $_counter wishes add another one ! ' : 'The list is empty, wanna add a wish ?'} ',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
