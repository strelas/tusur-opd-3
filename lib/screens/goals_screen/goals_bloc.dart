import 'package:flutter/material.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_app/services/app_storage.dart';
import 'package:flutter_app/services/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GoalsBlocEvent {}

class GoalsBlocNewGoal implements GoalsBlocEvent {
  final Goal newGoal;

  const GoalsBlocNewGoal({required this.newGoal});
}

class GoalsBlocRemoveGoal implements GoalsBlocEvent {
  final Goal toRemove;

  const GoalsBlocRemoveGoal({required this.toRemove});
}

class GoalsBlocOpenGoal implements GoalsBlocEvent {
  final Goal toOpen;

  const GoalsBlocOpenGoal(this.toOpen);
}

class GoalsBlocRemoveTask implements GoalsBlocEvent {
  final Task toRemove;

  const GoalsBlocRemoveTask(this.toRemove);
}

class GoalsBlocAddTask implements GoalsBlocEvent {
  final Task toAdd;

  const GoalsBlocAddTask(this.toAdd);
}

class GoalsBlocOpenList implements GoalsBlocEvent {}

class GoalsBlocChangeDate implements GoalsBlocEvent {
  final DateTime newDate;
  final Goal goal;

  const GoalsBlocChangeDate(this.newDate, this.goal);
}

class GoalsBlocChangeText implements GoalsBlocEvent {
  final String text;
  final Goal goal;

  const GoalsBlocChangeText(this.text, this.goal);
}

class GoalsBlocSetTimer implements GoalsBlocEvent {
  final TimeOfDay timer;
  final Task task;

  const GoalsBlocSetTimer(this.timer, this.task);
}

abstract class GoalsPageState {}

class GoalsPageStateList implements GoalsPageState {
  final List<Goal> goals;

  const GoalsPageStateList({required this.goals});
}

class GoalsPageStateSingleGoal implements GoalsPageState {
  final Goal goal;

  GoalsPageStateSingleGoal(this.goal);
}

class GoalsBloc extends Bloc<GoalsBlocEvent, GoalsPageState> {
  GoalsPageStateList _stateList;

  GoalsBloc(GoalsPageStateList initialState)
      : _stateList = initialState,
        super(initialState) {
    on<GoalsBlocNewGoal>((event, emit) {
      final goals = _stateList.goals.toList()..add(event.newGoal);
      emit(GoalsPageStateList(goals: goals));
    });

    on<GoalsBlocRemoveGoal>((event, emit) {
      final goals = _stateList.goals.toList()..remove(event.toRemove);
      emit(GoalsPageStateList(goals: goals));
    });

    on<GoalsBlocOpenGoal>((event, emit) {
      emit(GoalsPageStateSingleGoal(event.toOpen));
    });

    on<GoalsBlocRemoveTask>((event, emit) {
      final state = this.state;
      if (state is GoalsPageStateSingleGoal) {
        final indexOfOpenedGoal = _stateList.goals.indexOf(state.goal);
        final newList = _stateList.goals.toList();
        newList[indexOfOpenedGoal].tasks.remove(event.toRemove);
        _stateList = GoalsPageStateList(goals: newList);
        emit(GoalsPageStateSingleGoal(newList[indexOfOpenedGoal]));
      }
    });

    on<GoalsBlocAddTask>((event, emit) {
      final state = this.state;
      if (state is GoalsPageStateSingleGoal) {
        final indexOfOpenedGoal = _stateList.goals.indexOf(state.goal);
        final newList = _stateList.goals.toList();
        newList[indexOfOpenedGoal].tasks.add(event.toAdd);
        _stateList = GoalsPageStateList(goals: newList);
        emit(GoalsPageStateSingleGoal(newList[indexOfOpenedGoal]));
      }
    });

    on<GoalsBlocOpenList>((event, emit) {
      emit(_stateList);
    });

    on<GoalsBlocChangeDate>((event, emit) {
      final indexOfChanging =
          _stateList.goals.indexWhere((element) => element == event.goal);
      final newList = _stateList.goals.toList();
      newList[indexOfChanging] =
          newList[indexOfChanging].copyWith(date: event.newDate);
      emit(GoalsPageStateList(goals: newList));
    });

    on<GoalsBlocChangeText>((event, emit) {
      final indexOfChanging = _stateList.goals.indexOf(event.goal);
      final newList = _stateList.goals.toList();
      newList[indexOfChanging] =
          newList[indexOfChanging].copyWith(text: event.text);
      emit(GoalsPageStateList(goals: newList));
    });

    on<GoalsBlocSetTimer>((event, emit) {
      final state = this.state;
      if (state is GoalsPageStateSingleGoal) {
        final indexOfChanging = state.goal.tasks.indexOf(event.task);
        final dateTime = DateTime.now().add(Duration(
          hours: event.timer.hour,
          minutes: event.timer.minute,
        ));
        final newList = _stateList.goals.toList();
        final indexOfGoal = newList.indexOf(state.goal);
        final newTask = newList[indexOfGoal].tasks[indexOfChanging].copyWith(
              timeOfEnd: dateTime,
              started: true,
            );
        newList[indexOfGoal].tasks[indexOfChanging] = newTask;
        _stateList = GoalsPageStateList(goals: newList);
        emit(GoalsPageStateSingleGoal(newList[indexOfGoal]));
        NotificationService.shared.setLocalNotification(
          dateTime,
          event.task.text,
        );
      }
    });

    stream.listen((state) {
      if (state is GoalsPageStateList) {
        AppStorage.shared.saveGoals(state.goals);
        _stateList = state;
      }
    });
  }
}
