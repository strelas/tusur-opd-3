import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_app/screens/goals_screen/goals_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/src/provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function onRemove;
  final Function onTap;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onRemove,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Dismissible(
      onDismissed: (_) {
        onRemove();
      },
      direction: DismissDirection.endToStart,
      key: ValueKey("GoalItem: ${task.hashCode}"),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () async {
            if (task.started) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10,),
                      Text("Осталось: " + task.timeOfEnd!
                          .difference(DateTime.now())
                          .toString().split(".").first),
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: theme.color5),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              final timer = await showTimePicker(
                helpText: AppLocalizations.of(context)!.timer,
                context: context,
                initialTime: const TimeOfDay(hour: 0, minute: 0),
              );
              if (timer == null) {
                return;
              }

              context.read<GoalsBloc>().add(GoalsBlocSetTimer(timer, task));
            }
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 5),
            height: 45,
            decoration: BoxDecoration(
              color: theme.color3,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!task.done)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.color5, width: 1.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )
                else
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: theme.color7,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.check,
                      color: theme.color1,
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  task.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      background: Row(
        children: [
          const Spacer(),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: theme.color8,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Icon(
              Icons.delete,
              color: theme.color1,
            ),
          ),
        ],
      ),
    );
  }
}
