import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_divider.dart';
import 'package:flutter_app/custom_theme.dart';
import 'package:flutter_app/entity/goal.dart';
import 'package:flutter_app/screens/goals_screen/custom_widgets/goal_item.dart';
import 'package:flutter_app/screens/goals_screen/goals_bloc.dart';
import 'package:flutter_app/screens/goals_screen/goals_list_page.dart';
import 'package:flutter_app/screens/goals_screen/single_goal_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final textEditingController = TextEditingController();
  var goals = <Goal>[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsBloc, GoalsPageState>(builder: (context, state) {
      if (state is GoalsPageStateList) {
        return GoalsListPage(
          state: state,
          textEditingController: textEditingController,
        );
      }
      if (state is GoalsPageStateSingleGoal) {
        return SingleGoalPageBody(
          state: state,
          textEditingController: textEditingController,
        );
      }
      return Container();
    });
  }
}
