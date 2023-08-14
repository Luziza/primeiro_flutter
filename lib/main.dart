import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Container(color: Colors.amber, height: 50, width: 50,),
            Container(color: Colors.blue, height: 50, width: 50,),
            Container(color: Colors.deepPurple, height: 50, width: 50,),

            Container(color: Colors.deepOrange, height: 50, width: 50,),
            Container(color: Colors.pink, height: 50, width: 50,),
            Container(color: Colors.teal, height: 50, width: 50,),

            Container(color: Colors.pinkAccent, height: 50, width: 50,),
            Container(color: Colors.blueAccent, height: 50, width: 50,),
            Container(color: Colors.lightGreenAccent, height: 50, width: 50,),
          ],
        ),
      ]
      )
    );
  }
}

