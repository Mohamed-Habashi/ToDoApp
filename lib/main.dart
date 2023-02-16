import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc_observer.dart';
import 'package:to_do_app/layout/cubit/todocubit.dart';

import 'layout/todolayout.dart';

void main() {
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ToDoCubit()..createDatabase(),
      child: const MaterialApp(
        home: ToDoLayout(),
      ),
    );
  }
}


