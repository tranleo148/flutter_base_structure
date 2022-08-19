part of 'language_bloc.dart';

@immutable
abstract class LanguageState extends Equatable {
  const LanguageState();
}

class LanguageInitial extends LanguageState {
  @override
  List<Object> get props => [];
}

class LanguageLoadingState extends LanguageState {
  final String message;

  const LanguageLoadingState(this.message);

  @override
  List<Object> get props => [];
}

class LanguageLoadedState extends LanguageState {
  final Locale locale;

  const LanguageLoadedState(this.locale);

  @override
  List<Object> get props => [locale];
}

class LanguageErrorState extends LanguageState {
  final String error;

  const LanguageErrorState(this.error);

  @override
  List<Object> get props => [error];
}
