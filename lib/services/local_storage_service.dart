import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class LocalStorageService {
  static const String taskKey = 'task_list';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final data = tasks.map((task) => task.toJson()).toList();
    await prefs.setStringList(taskKey, data);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(taskKey) ?? [];
    return data.map((item) => Task.fromJson(item)).toList();
  }
}