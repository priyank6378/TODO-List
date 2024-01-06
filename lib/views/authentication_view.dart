import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/const/routes.dart';
import 'package:to_do/services/database.dart';

class AuthenticateView extends StatefulWidget {
  const AuthenticateView({super.key});

  @override
  State<AuthenticateView> createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {
  final database = ToDoDatabase();
  final _password = "root";
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database.initiate(),
      builder: (context, snapshot) {
        // TODO: add the password update functionality and uncomment the below line
        // _password = database.getPassword();
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Center(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter Password",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        cursorWidth: 10,
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_passwordController.text == _password) {
                          Navigator.of(context).pushNamed(notesRoute);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Wrong Password"),
                            ),
                          );
                        }
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // TODO: change the notesRoute to updatePasswordRoute after adding the password update functionality
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            notesRoute, (route) => false);
                      },
                      child: const Text("Update Password"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
