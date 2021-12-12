import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_divider.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_app/screens/goals_screen/custom_widgets/back_arrow.dart';
import 'package:flutter_app/screens/goals_screen/custom_widgets/task_item.dart';
import 'package:flutter_app/screens/goals_screen/goals_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class SingleGoalPageBody extends StatelessWidget {
  final GoalsPageStateSingleGoal state;
  final TextEditingController textEditingController;

  const SingleGoalPageBody({
    Key? key,
    required this.state,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.read<GoalsBloc>().add(GoalsBlocOpenList());
          },
          child: Container(
            color: const Color(0x00000000),
            height: 20,
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const BackArrow(),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  AppLocalizations.of(context)!.tasks + " | ${state.goal.text}",
                  style: TextStyle(
                    color: theme.color5,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat.Hm().format(state.goal.date),
                  style: TextStyle(
                    color: theme.color5,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 25),
              ],
            ),
          ),
        ),
        const CustomDivider(),
        Expanded(
          child: ListView.builder(
            itemCount: state.goal.tasks.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: TaskItem(
                task: state.goal.tasks[index],
                onTap: () {},
                onRemove: () {
                  context
                      .read<GoalsBloc>()
                      .add(GoalsBlocRemoveTask(state.goal.tasks[index]));
                },
              ),
            ),
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
                        hintText: AppLocalizations.of(context)!.myTask,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  context.read<GoalsBloc>().add(
                        GoalsBlocAddTask(Task(
                          text: textEditingController.text,
                          done: false,
                          started: false,
                        )),
                      );
                  textEditingController.clear();
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
