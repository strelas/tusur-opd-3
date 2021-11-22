import 'package:flutter_app/services/app_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NotificationBlocEvents {
  enable,
  disable,
}

class NotificationBloc extends Bloc<NotificationBlocEvents, bool>{
  NotificationBloc(bool initialValue) : super(initialValue) {
    on<NotificationBlocEvents>((event, emit) {
      final enabled = event == NotificationBlocEvents.enable;
      AppStorage.shared.saveIsNotificationEnabled(enabled: enabled);
      emit(enabled);
    });
  }
}