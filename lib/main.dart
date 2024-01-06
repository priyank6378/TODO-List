import 'package:flutter/material.dart';
import 'package:to_do/const/routes.dart';
import 'package:to_do/views/authentication_view.dart';
import 'package:to_do/views/new_todo.dart';
import 'package:to_do/views/todo_list.dart';

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
      home: const AuthenticateView(),
      routes: {
        newNoteRoute: (context) => const AddNewTodoItem(),
        notesRoute: (context) => const ToDoListView(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ToDoListView();
  }
}
