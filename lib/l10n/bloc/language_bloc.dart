import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  _changeLanguage(ChangeLanguageEvent event, Emitter<LanguageState> emit) async {
    emit(LanguageLoadingState('Changing Language to ${event.locale.toLanguageTag()}'));
    try {
      emit(LanguageLoadedState(event.locale));
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      emit(LanguageErrorState(e.toString()));
    }
  }
}
