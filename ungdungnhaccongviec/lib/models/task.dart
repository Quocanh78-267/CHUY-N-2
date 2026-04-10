import 'dart:convert';

class Task {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final bool remindBeforeOneDay;
  final String reminderType;
  final bool completed;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.remindBeforeOneDay,
    required this.reminderType,
    required this.completed,
  });

  Task copyWith({
    String? id,
    String? title,
    String? date,
    String? time,
    String? location,
    bool? remindBeforeOneDay,
    String? reminderType,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      remindBeforeOneDay: remindBeforeOneDay ?? this.remindBeforeOneDay,
      reminderType: reminderType ?? this.reminderType,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'remindBeforeOneDay': remindBeforeOneDay,
      'reminderType': reminderType,
      'completed': completed,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      remindBeforeOneDay: map['remindBeforeOneDay'] ?? true,
      reminderType: map['reminderType'] ?? 'Nhắc bằng chuông',
      completed: map['completed'] ?? false,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(jsonDecode(source));
}