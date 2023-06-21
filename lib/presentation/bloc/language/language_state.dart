import 'package:equatable/equatable.dart';

import '../../../localization/language.dart';

class LanguageState extends Equatable {
  final Language selectedLanguage;

  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.english;

  @override
  List<Object> get props => [selectedLanguage];

  LanguageState copyWith({Language? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
