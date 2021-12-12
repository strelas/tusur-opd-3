import 'package:flutter/material.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_app/screens/goals_screen/goals_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/src/provider.dart';

class GoalItem extends StatelessWidget {
  final Function onRemove;
  final Goal goal;

  const GoalItem({
    Key? key,
    required this.onRemove,
    required this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Dismissible(
      onDismissed: (_) {
        onRemove();
      },
      direction: DismissDirection.endToStart,
      key: ValueKey("GoalItem: ${goal.hashCode}"),
      child: GestureDetector(
        onTap: () {
          context.read<GoalsBloc>().add(GoalsBlocOpenGoal(goal));
        },
        onLongPressStart: (details) async {
          final overlay = Overlay.of(context)?.context.findRenderObject()!;
          final selected = await showMenu(
              context: context,
              position: RelativeRect.fromRect(
                (details.globalPosition) & (const Size(40, 40)),
                Offset.zero & overlay!.semanticBounds.size,
              ),
              items: [
                PopupMenuItem(
                  value: 0,
                  child: Text(AppLocalizations.of(context)!.changeText),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text(AppLocalizations.of(context)!.changeDate),
                ),
              ]);
          if (selected == null) {
            return;
          }
          if (selected == 0) {
            final textController = TextEditingController();
            final text = await showDialog<String>(
              context: context,
              builder: (context) => Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.textHint,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(textController.text);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
            if (text != null) {
              context.read<GoalsBloc>().add(GoalsBlocChangeText(text, goal));
            }
          } else if (selected == 1) {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 350)),
            );

            if (date == null) {
              return;
            }
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time == null) {
              return;
            }
            final newDate = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            context.read<GoalsBloc>().add(GoalsBlocChangeDate(newDate, goal));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
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
                if (!goal.done)
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
                  goal.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${goal.date.day}.${goal.date.month}.${goal.date.year}",
                      style: TextStyle(
                          color: theme.color5,
                          fontSize: 8,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.done}: ${goal.tasks.where((element) => element.done).length}/${goal.tasks.length}",
                      style: TextStyle(
                          color: theme.color5,
                          fontSize: 8,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
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
