import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  // LanguageBloc(super.initialState);


  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
    // on<GetLanguage>(onGetLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) {
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

}