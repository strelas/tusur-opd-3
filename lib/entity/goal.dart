import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Goal {
  final String text;
  final bool done;
  final DateTime date;
  final List<Task> tasks;

  const Goal({
    required this.text,
    required this.done,
    required this.date,
    required this.tasks,
  });

  Goal copyWith({DateTime? date, String? text}) => Goal(
        text: text ?? this.text,
        done: done,
        date: date ?? this.date,
        tasks: tasks,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "done": done,
        "date": date.microsecondsSinceEpoch,
        "tasks": tasks,
      };

  static Goal fromJson(Map<String, dynamic> json) {
    return Goal(
      text: json["text"],
      done: json["done"],
      date: DateTime.fromMicrosecondsSinceEpoch(json["date"]),
      tasks: (json["tasks"] as List).map((e) => Task.fromJson(e)).toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (other is! Goal) {
      return false;
    }
    if (text != other.text) {
      return false;
    }
    if (done != other.done) {
      return false;
    }
    if (date != other.date) {
      return false;
    }
    if (!(const ListEquality().equals(tasks, other.tasks))) {
      return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'Goal{text: $text, done: $done, date: $date, tasks: $tasks}';
  }

  @override
  int get hashCode => hashValues(
        text,
        done,
        date,
        const ListEquality().hash(tasks),
      );
}

class Task {
  final String text;
  final bool done;
  final bool started;
  final DateTime? timeOfEnd;

  const Task(
      {required this.text,
      required this.done,
      required this.started,
      this.timeOfEnd});

  Task copyWith({bool? started, bool? done, DateTime? timeOfEnd}) => Task(
        text: text,
        done: done ?? this.done,
        started: started ?? this.done,
        timeOfEnd: timeOfEnd ?? this.timeOfEnd,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "done": done,
        "started": started,
        "timeOfEnd": timeOfEnd == null
            ? null
            : timeOfEnd!.toIso8601String(),
      };

  Task.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        done = json["done"],
        started = json["started"],
        timeOfEnd = json["timeOfEnd"] == null
            ? null
            : DateTime.parse(json["timeOfEnd"]);

  @override
  bool operator ==(Object other) {
    if (other is! Task) {
      return false;
    }

    if (other.done != done) {
      return false;
    }

    if (other.text != text) {
      return false;
    }

    if (other.started != started) {
      return false;
    }

    if (timeOfEnd != other.timeOfEnd) {
      return false;
    }

    return true;
  }

  @override
  String toString() {
    return 'Task{text: $text, done: $done, started: $started, timeOfEnd: $timeOfEnd}';
  }

  @override
  int get hashCode => hashValues(text, done, started, timeOfEnd);
}
