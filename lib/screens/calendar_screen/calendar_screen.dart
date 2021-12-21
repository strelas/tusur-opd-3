import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_divider.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_app/screens/goals_screen/custom_widgets/goal_item.dart';
import 'package:flutter_app/screens/goals_screen/goals_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/src/provider.dart';

import '../../custom_theme.dart';

class CalendarScreen extends StatefulWidget {
  final GoalsPageStateList state;

  const CalendarScreen({Key? key, required this.state}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final date = DateTime.now();
  List months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октабрь',
    'Ноябрь',
    'Декабрь'
  ];

  @override
  Widget build(BuildContext context) {
    final goals = widget.state.goals;
    final theme = CustomTheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: theme.color5,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
        ),
        Container(
          height: 225,
          decoration: BoxDecoration(
            color: theme.color4,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 13, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 350)));
                  },
                  child: Row(
                    children: [
                      Text(
                        '${months[date.month - 1]} ${date.year}',
                        style: TextStyle(
                            fontSize: 11,
                            color: theme.color6,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/downArrow.svg',
                        color: theme.color6,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/leftArrow.svg',
                  color: theme.color6,
                ),
                SizedBox(
                  width: 55,
                ),
                SvgPicture.asset(
                  'assets/rightArrow.svg',
                  color: theme.color6,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        goals == []
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 31),
                    child: Text(
                      AppLocalizations.of(context)!.goals,
                      style: TextStyle(color: theme.color5, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const CustomDivider(),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Center(
                    child: Text(
                  'Нет целей',
                  style: TextStyle(color: theme.color3, fontSize: 18),
                )),
              ),
        goals == []
            ? Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GoalItem(
                        onRemove: () {
                          context
                              .read<GoalsBloc>()
                              .add(GoalsBlocRemoveGoal(toRemove: goals[index]));
                        },
                        goal: goals[index],
                      ),
                    );
                  },
                  itemCount: goals.length,
                ),
              )
            : Container(),
      ],
    );
  }
}
