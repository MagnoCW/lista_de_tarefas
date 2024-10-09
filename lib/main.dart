import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/my_home_page.dart';

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
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E88E5))),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
