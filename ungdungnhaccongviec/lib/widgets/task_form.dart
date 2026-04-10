import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskForm extends StatefulWidget {
  final Task? editingTask;
  final Function(Task) onSave;
  final VoidCallback onCancel;

  const TaskForm({
    super.key,
    required this.editingTask,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController locationController;

  bool remindBeforeOneDay = true;
  String reminderType = 'Nhắc bằng chuông';

  @override
  void initState() {
    super.initState();
    final task = widget.editingTask;
    titleController = TextEditingController(text: task?.title ?? '');
    dateController = TextEditingController(text: task?.date ?? '');
    timeController = TextEditingController(text: task?.time ?? '');
    locationController = TextEditingController(text: task?.location ?? '');
    remindBeforeOneDay = task?.remindBeforeOneDay ?? true;
    reminderType = task?.reminderType ?? 'Nhắc bằng chuông';
  }

  @override
  void didUpdateWidget(covariant TaskForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.editingTask?.id != widget.editingTask?.id) {
      final task = widget.editingTask;
      titleController.text = task?.title ?? '';
      dateController.text = task?.date ?? '';
      timeController.text = task?.time ?? '';
      locationController.text = task?.location ?? '';
      remindBeforeOneDay = task?.remindBeforeOneDay ?? true;
      reminderType = task?.reminderType ?? 'Nhắc bằng chuông';
      setState(() {});
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateController.text =
      '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() {});
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      timeController.text =
      '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      setState(() {});
    }
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: widget.editingTask?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text.trim(),
        date: dateController.text.trim(),
        time: timeController.text.trim(),
        location: locationController.text.trim(),
        remindBeforeOneDay: remindBeforeOneDay,
        reminderType: reminderType,
        completed: widget.editingTask?.completed ?? false,
      );
      widget.onSave(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editingTask != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              isEditing ? 'Cập nhật công việc' : 'Thêm công việc',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Tên công việc',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập tên công việc';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: dateController,
              readOnly: true,
              onTap: pickDate,
              decoration: const InputDecoration(
                labelText: 'Ngày',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng chọn ngày';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: timeController,
              readOnly: true,
              onTap: pickTime,
              decoration: const InputDecoration(
                labelText: 'Giờ',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.access_time),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Địa điểm',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: remindBeforeOneDay,
              onChanged: (value) {
                setState(() {
                  remindBeforeOneDay = value;
                });
              },
              title: const Text('Nhắc việc trước 1 ngày'),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: reminderType,
              decoration: const InputDecoration(
                labelText: 'Hình thức nhắc',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Nhắc bằng chuông',
                  child: Text('Nhắc bằng chuông'),
                ),
                DropdownMenuItem(
                  value: 'Nhắc bằng email',
                  child: Text('Nhắc bằng email'),
                ),
                DropdownMenuItem(
                  value: 'Nhắc bằng thông báo',
                  child: Text('Nhắc bằng thông báo'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  reminderType = value ?? 'Nhắc bằng chuông';
                });
              },
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: submit,
                    child: Text(isEditing ? 'Cập nhật' : 'Lưu công việc'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    child: const Text('Làm mới'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}