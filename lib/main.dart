import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'lab2.dart';
import 'lab3.dart';
import 'lab4.dart';
import 'lab5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/lab2': (context) => const Lab2(),
        '/lab3': (context) => const Lab3(),
        '/lab4': (context) => const Lab4(),
        '/lab5': (context) => const Lab5(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/lab2':
            return PageTransition(
                child: const Lab2(), type: PageTransitionType.topToBottom);
          case '/la3':
            return PageTransition(
                child: const Lab3(), type: PageTransitionType.topToBottom);
          case '/lab4':
            return PageTransition(
                child: const Lab4(), type: PageTransitionType.topToBottom);
          case '/lab5':
            return PageTransition(
                child: const Lab5(), type: PageTransitionType.topToBottom);
          default:
            return null;
        }
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
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
  bool gender1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orange)),
                      child: const Text(
                        "Lab 2",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/lab2');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/lab3');
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orange)),
                      child: const Text(
                        "Lab 3",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/lab4');
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orange)),
                      child: const Text(
                        "Lab 4",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
