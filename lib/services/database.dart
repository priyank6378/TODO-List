import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ToDoDatabase {
  SharedPreferences? sharedPreferences;

  Future<SharedPreferences?> initiate() async {
    final tmpSharedPreference = await SharedPreferences.getInstance();
    sharedPreferences = tmpSharedPreference;
    return tmpSharedPreference;
  }

  void add(String todoNote) async {
    final tmpSharedPreferences = sharedPreferences;
    if (tmpSharedPreferences == null) {
      await initiate();
    }
    String? todoMapString = sharedPreferences?.getString("notes");
    todoMapString ??= "{}";
    final todoMap = jsonDecode(todoMapString);
    todoMap[todoNote] = false;
    await sharedPreferences?.setString("notes", jsonEncode(todoMap));
  }

  void done(String todoNote) async {
    final todoStringMap = sharedPreferences?.getString("notes");
    if (todoStringMap != null) {
      final todoMap = jsonDecode(todoStringMap);
      todoMap[todoNote] = true;
      await sharedPreferences?.setString("notes", jsonEncode(todoMap));
    }
  }

  void unDone(String todoNote) async {
    final todoStringMap = sharedPreferences?.getString("notes");
    if (todoStringMap != null) {
      final todoMap = jsonDecode(todoStringMap);
      todoMap[todoNote] = false;
      await sharedPreferences?.setString("notes", jsonEncode(todoMap));
    }
  }

  void delete(String todoNote) async {
    final todoStringMap = sharedPreferences?.getString("notes");
    if (todoStringMap != null) {
      final todoMap = jsonDecode(todoStringMap);
      todoMap.remove(todoNote);
      await sharedPreferences?.setString("notes", jsonEncode(todoMap));
    }
  }

  Map<String, bool?> getAll() {
    final tmpSharedPreferences = sharedPreferences;
    String? todoMapString = tmpSharedPreferences?.getString("notes");
    print(todoMapString);
    if (todoMapString == null) {
      return {};
    }
    final allNotes = jsonDecode(todoMapString);
    Map<String, bool?> allNotesMap = {};
    allNotes.forEach((key, value) {
      if (value is bool) {
        allNotesMap[key] = value;
      }
    });
    return allNotesMap;
  }

  String? getPassword() {
    return sharedPreferences?.getString("password");
  }

  void setPassword(String password) async {
    await sharedPreferences?.setString("password", password);
  }
}

class UnableToGetSharedInstanceException implements Exception {}
