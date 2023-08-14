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
                Container(color: Colors.amber, height: 100, width: 100,),
                Container(color: Colors.blue, height: 100, width: 100,),
                Container(color: Colors.deepPurple, height: 100, width: 100,),
              ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
            Container(color: Colors.deepPurple, height: 100, width: 100,),
            Container(color: Colors.lightGreen, height: 100, width: 100,),
            Container(color: Colors.pink, height: 100, width: 100,),
        ]
    ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Container(color: Colors.deepOrange, height: 100, width: 100,),
                  Container(color: Colors.indigo, height: 100, width: 100,),
                  Container(color: Colors.purpleAccent, height: 100, width: 100,),
                ]
            ),
      ]
        ),
    );
  }
}

