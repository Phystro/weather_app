import 'package:equatable/equatable.dart';

import '../../../localization/language.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final Language selectedLanguage;

  const ChangeLanguage({required this.selectedLanguage});

  @override
  List<Object> get props => [selectedLanguage];
}

class GetLanguage extends LanguageEvent {}