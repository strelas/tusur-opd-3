import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/calendar_screen/calendar_screen.dart';
import 'package:flutter_app/screens/goals_screen/goals_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarProvider extends StatefulWidget {
  const CalendarProvider({Key? key}) : super(key: key);

  @override
  _CalendarProviderState createState() => _CalendarProviderState();
}

class _CalendarProviderState extends State<CalendarProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsBloc, GoalsPageState>(builder: (context, state) {
      if (state is GoalsPageStateList) {
        return CalendarScreen(
          state: state,
        );
      }
      return Container();
    });
  }
}
