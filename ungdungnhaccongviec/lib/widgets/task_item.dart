import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final bool dueSoon;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;

  const TaskItem({
    super.key,
    required this.task,
    required this.dueSoon,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = task.completed
        ? Colors.grey.shade100
        : dueSoon
        ? Colors.orange.shade50
        : Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration:
                    task.completed ? TextDecoration.lineThrough : null,
                    color: task.completed ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              Checkbox(
                value: task.completed,
                onChanged: (_) => onToggleComplete(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Thời gian: ${task.date} ${task.time}'),
          const SizedBox(height: 4),
          Text(
            'Địa điểm: ${task.location.isEmpty ? 'Chưa có địa điểm' : task.location}',
          ),
          const SizedBox(height: 4),
          Text('Nhắc: ${task.reminderType}'),
          const SizedBox(height: 10),
          if (dueSoon && !task.completed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Công việc sắp đến hạn',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
                label: const Text('Sửa'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Xóa',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}