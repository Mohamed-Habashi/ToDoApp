import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/layout/cubit/todostates.dart';

import '../../screens/archive_list_screen.dart';
import '../../screens/done_list_screen.dart';
import '../../screens/new_list_screen.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(ToDoInitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'New List'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.check,
        ),
        label: 'Done List'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.archive,
        ),
        label: 'Archive List'),
  ];

  List<Widget> screens = [
    const NewListScreen(),
    const DoneListScreen(),
    const ArchiveListScreen(),
  ];

  int currentIndex = 0;

  changeBottomNavigation(index) {
    currentIndex = index;
    emit(ToDoChangeBottomNavigationSuccessState());
  }

  Database? database;

  createDatabase() {
    openDatabase('data.db', version: 1, onCreate: (Database db, int version) {
      db
          .execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, status TEXT)')
          .then((value) {});
    }, onOpen: (database) {
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(ToDoDatabaseCreatedSuccessState());
    }).catchError((error) {
      emit(ToDoDatabaseCreatedErrorState());
    });
  }

  insertIntoDatabase({required String task}) {
    database?.transaction((txn) {
      return txn
          .rawInsert('INSERT INTO Test(name, status) VALUES("$task","new")')
          .then((value) {});
    }).then((value) {
      emit(ToDoInsertSuccessState());
      getDataFromDatabase(database);
    }).catchError((error) {
      emit(ToDoInsertErrorState());
    });
  }

  List newTasks = [];
  List doneTasks = [];
  List archiveTasks = [];

  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    database.rawQuery('SELECT * FROM Test').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(ToDoGetDataSuccessState());
    }).catchError((error) {
      emit(ToDoGetDataErrorState());
    });
  }

  updateDatabase({
    required String status,
    required int id,
  }) {
    database
        ?.rawUpdate('UPDATE Test SET status = ? WHERE id = ?',
        [status,id]
    ).then((value){
      getDataFromDatabase(database);
      emit(ToDoGetDataUpdateSuccessState());
    }).catchError((error){
      emit(ToDoGetDataErrorState());
    });
  }

  deleteDatabase({
   required int id
}){
    database?.rawDelete(
        'DELETE FROM Test WHERE id = ?',
        [id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(ToDoDeleteDataSuccessState());
    }).catchError((error){
      emit(ToDoDeleteDataErrorState());
    });
  }
}
