import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_divider.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_app/screens/goals_screen/custom_widgets/goal_item.dart';
import 'package:flutter_app/screens/goals_screen/goals_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoalsListPage extends StatelessWidget {
  final GoalsPageStateList state;
  final TextEditingController textEditingController;
  const GoalsListPage({
    Key? key,
    required this.state,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goals = state.goals;
    final theme = CustomTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            AppLocalizations.of(context)!.allGoals,
            style: TextStyle(
              color: theme.color5,
            ),
          ),
        ),
        const CustomDivider(),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GoalItem(
                  onRemove: () {
                    context.read<GoalsBloc>().add(
                        GoalsBlocRemoveGoal(toRemove: goals[index]));
                  },
                  goal: goals[index],
                ),
              );
            },
            itemCount: goals.length,
          ),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: theme.color3,
            border: Border(
              top: BorderSide(color: theme.color5),
              bottom: BorderSide(color: theme.color5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 5,
                    bottom: 5,
                    right: 15,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: theme.color1,
                    ),
                    child: TextFormField(
                      controller: textEditingController,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: theme.fontColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: theme.color7,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                        hintText: AppLocalizations.of(context)!.myGoal,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 350)),
                  ).then((value) {
                    if (value != null) {
                      context.read<GoalsBloc>().add(
                        GoalsBlocNewGoal(
                          newGoal: Goal(
                            text: textEditingController.text,
                            done: false,
                            date: value,
                            tasks: [],
                          ),
                        ),
                      );
                      textEditingController.clear();
                    }
                  });
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: const Color(0xFF005BAC),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color.alphaBlend(theme.color3, theme.color1),
                  ),
                ),
              ),
              const SizedBox(width: 11),
            ],
          ),
        ),
      ],
    );
  }
}
