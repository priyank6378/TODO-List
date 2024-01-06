import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/const/routes.dart';
import 'package:to_do/services/database.dart';

class ToDoListView extends StatefulWidget {
  const ToDoListView({super.key});

  @override
  State<ToDoListView> createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  ToDoDatabase database = ToDoDatabase();
  Map<String, bool?> todoNotes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffacc15),
        title: Text(
          "TO-DO List",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(newNoteRoute);
            },
          )
        ],
      ),
      // backgroundColor: const Color(0xfffef08a),
      body: FutureBuilder(
        future: database.initiate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            todoNotes = database.getAll();
            if (todoNotes.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: todoNotes.length,
                itemBuilder: (context, index) {
                  final indexedNote = todoNotes.keys.toList()[index];
                  return Container(
                      height: 80,
                      // width: 100,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        // color: const Color(0xfffacc15),
                        border: Border.all(
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Checkbox(
                            value: todoNotes[indexedNote],
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  database.done(indexedNote);
                                } else {
                                  database.unDone(indexedNote);
                                }
                              });
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              database.delete(indexedNote);
                              setState(() {});
                            },
                            alignment: Alignment.topLeft,
                            icon: const Icon(Icons.delete),
                          ),
                          Expanded(
                            child: Text(
                              indexedNote,
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                decoration: (todoNotes[indexedNote] ?? false)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.white,
                ),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  "No Tasks!",
                  style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
