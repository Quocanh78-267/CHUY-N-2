import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/local_storage_service.dart';
import '../widgets/filter_bar.dart';
import '../widgets/stats_card.dart';
import '../widgets/task_form.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  List<Task> tasks = [];
  List<Task> filteredTasks = [];
  Task? editingTask;
  String selectedStatus = 'Tất cả';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadTasks() async {
    final loadedTasks = await LocalStorageService.loadTasks();
    tasks = loadedTasks;
    applyFilters();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> saveTasks() async {
    await LocalStorageService.saveTasks(tasks);
  }

  void addOrUpdateTask(Task task) async {
    final index = tasks.indexWhere((item) => item.id == task.id);

    setState(() {
      if (index >= 0) {
        tasks[index] = task;
      } else {
        tasks.insert(0, task);
      }
      editingTask = null;
    });

    await saveTasks();
    applyFilters();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(index >= 0
            ? 'Đã cập nhật công việc'
            : 'Đã thêm công việc mới'),
      ),
    );
  }

  void deleteTask(String id) async {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
      if (editingTask?.id == id) {
        editingTask = null;
      }
    });

    await saveTasks();
    applyFilters();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đã xóa công việc')),
    );
  }

  void toggleComplete(Task task) async {
    final index = tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;

    setState(() {
      tasks[index] = tasks[index].copyWith(
        completed: !tasks[index].completed,
      );
    });

    await saveTasks();
    applyFilters();
  }

  void applyFilters() {
    final keyword = searchController.text.trim().toLowerCase();

    List<Task> result = tasks.where((task) {
      final matchesKeyword =
          task.title.toLowerCase().contains(keyword) ||
              task.location.toLowerCase().contains(keyword) ||
              task.reminderType.toLowerCase().contains(keyword);

      final matchesStatus = selectedStatus == 'Tất cả'
          ? true
          : selectedStatus == 'Đã hoàn thành'
          ? task.completed
          : !task.completed;

      return matchesKeyword && matchesStatus;
    }).toList();

    result.sort((a, b) {
      final aDate = _parseTaskDateTime(a);
      final bDate = _parseTaskDateTime(b);
      return aDate.compareTo(bDate);
    });

    setState(() {
      filteredTasks = result;
    });
  }

  DateTime _parseTaskDateTime(Task task) {
    final raw = '${task.date} ${task.time.isEmpty ? '00:00' : task.time}';
    return DateTime.tryParse(raw) ?? DateTime(2100);
  }

  bool isDueSoon(Task task) {
    if (!task.remindBeforeOneDay || task.date.isEmpty || task.completed) {
      return false;
    }

    final taskDate = _parseTaskDateTime(task);
    final now = DateTime.now();
    final difference = taskDate.difference(now);

    return difference.inHours >= 0 && difference.inHours <= 24;
  }

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((e) => e.completed).length;
  int get pendingTasks => tasks.where((e) => !e.completed).length;
  int get dueSoonTasks => tasks.where((e) => isDueSoon(e)).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Ứng dụng công việc'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskForm(
                editingTask: editingTask,
                onSave: addOrUpdateTask,
                onCancel: () {
                  setState(() {
                    editingTask = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  StatsCard(title: 'Tổng công việc', value: totalTasks),
                  StatsCard(title: 'Chưa xong', value: pendingTasks),
                  StatsCard(
                    title: 'Đã hoàn thành',
                    value: completedTasks,
                  ),
                  StatsCard(title: 'Sắp đến hạn', value: dueSoonTasks),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Danh sách công việc',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              FilterBar(
                searchController: searchController,
                selectedStatus: selectedStatus,
                onStatusChanged: (value) {
                  selectedStatus = value;
                  applyFilters();
                },
                onSearchChanged: applyFilters,
              ),
              const SizedBox(height: 16),
              if (filteredTasks.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Chưa có công việc phù hợp',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              else
                ...filteredTasks.map(
                      (task) => TaskItem(
                    task: task,
                    dueSoon: isDueSoon(task),
                    onEdit: () {
                      setState(() {
                        editingTask = task;
                      });
                    },
                    onDelete: () => deleteTask(task.id),
                    onToggleComplete: () => toggleComplete(task),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}