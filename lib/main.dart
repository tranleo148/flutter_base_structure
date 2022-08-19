import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'src/app/app.dart';
import 'src/app/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
