import 'dart:convert';

enum TaskPriority { low, medium, high }

extension TaskPriorityExtension on String {
  TaskPriority toTaskPriority() {
    switch (toLowerCase()) {
      case 'low':
        return TaskPriority.low;
      case 'medium':
        return TaskPriority.medium;
      case 'high':
        return TaskPriority.high;
      default:
        throw ArgumentError('Invalid TaskPriority value: $this');
    }
  }
}

class Task {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String title;
  final String description;
  final bool completed;
  final DateTime? dueDate;
  final TaskPriority priority;

  Task({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.title,
    required this.description,
    this.completed = false,
    this.dueDate,
    required this.priority,
  });

  Task copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    bool? completed,
    DateTime? dueDate,
    TaskPriority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'title': title,
      'description': description,
      'completed': completed,
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority.name,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'] as String)
          : null,
      title: map['title'] as String,
      description: map['description'] as String,
      completed: map['completed'] as bool,
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'] as String)
          : null,
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == map['priority'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, description: $description, completed: $completed, dueDate: $dueDate, priority: $priority)';
  }

  Task toModel() {
    return Task(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      title: title,
      description: description,
      completed: completed,
      dueDate: dueDate,
      priority: priority,
    );
  }
}
