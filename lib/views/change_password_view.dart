import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/const/routes.dart';
import 'package:to_do/services/database.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final database = ToDoDatabase();
  String? newPassword;
  String? currentPassword;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database.initiate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          currentPassword = database.getPassword();
          return Scaffold(
            appBar: AppBar(
              title: const Text("Change Password"),
              centerTitle: true,
            ),
            body: Center(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update Password",
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
                        controller: _oldPasswordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Current Password',
                        ),
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
                        currentPassword = database.getPassword();
                        final oldPasswordText = _oldPasswordController.text;
                        final newPasswordText = _passwordController.text;
                        if (oldPasswordText == currentPassword) {
                          database.setPassword(newPasswordText);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              notesRoute, (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Wrong Password"),
                            ),
                          );
                        }
                      },
                      child: const Text("Change Password"),
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
