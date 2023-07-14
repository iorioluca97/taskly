import 'package:flutter/material.dart';

class Task {
  String content;
  DateTime timestamp;
  bool isDone;

  Task({
    required this.content,
    required this.timestamp,
    required this.isDone,
  });
  /* creo una funzione che trasforma 
  le variabili di Task
  in una Map da fornire ad Hive */
  Map toMap() {
    return {
      "content": content,
      "timestamp": timestamp,
      "isDone": isDone,
    };
  }

  factory Task.fromMap(Map task) {
    return Task(
      content: task['content'],
      timestamp: task['timestamp'],
      isDone: task['isDone'],
    );
  }
}
