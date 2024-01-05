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
    tmpSharedPreferences?.setBool(todoNote, false);
  }

  void done(String todoNote) async {
    await sharedPreferences?.setBool(todoNote, true);
  }

  void unDone(String todoNote) async {
    await sharedPreferences?.setBool(todoNote, false);
  }

  void delete(String todoNote) async {
    await sharedPreferences?.remove(todoNote);
  }

  Map<String, bool?> getAll() {
    final allNotes = sharedPreferences?.getKeys();
    Map<String, bool?> todoMap = {};
    if (allNotes != null) {
      for (String note in allNotes) {
        todoMap[note] = sharedPreferences?.getBool(note);
      }
      return todoMap;
    }
    return {};
  }
}

class UnableToGetSharedInstanceException implements Exception {}
