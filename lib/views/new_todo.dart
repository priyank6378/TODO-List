import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/const/routes.dart';
import 'package:to_do/services/database.dart';

class AddNewTodoItem extends StatefulWidget {
  const AddNewTodoItem({super.key});

  @override
  State<AddNewTodoItem> createState() => _AddNewTodoItemState();
}

class _AddNewTodoItemState extends State<AddNewTodoItem> {
  final textController = TextEditingController();
  final database = ToDoDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: database.initiate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              // backgroundColor: const Color(0xfffef08a),
              appBar: AppBar(
                backgroundColor: const Color(0xffc084fc),
                title: Text(
                  "New Task",
                  style: GoogleFonts.poppins(),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      final note = textController.text;
                      if (note.isNotEmpty) {
                        database.add(note);
                        print("Added new note here: ");
                        print(database.sharedPreferences?.getString("notes"));
                      }
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          notesRoute, (route) => false);
                    },
                    icon: const Icon(Icons.check),
                  )
                ],
              ),
              body: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write your TODO item here...",
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
