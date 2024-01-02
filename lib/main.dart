import 'package:flutter/material.dart';
import 'package:primeiro/Tarefa.dart';
import 'package:primeiro/Formulario.dart';
import 'package:primeiro/data.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool opacidade = true;
  get children => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TaskInherite(child: const Tarefa())
    );
  }
}