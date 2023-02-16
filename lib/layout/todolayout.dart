import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/const.dart';
import 'package:to_do_app/layout/cubit/todocubit.dart';
import 'package:to_do_app/layout/cubit/todostates.dart';

var textController = TextEditingController();
var global=GlobalKey<FormState>();

class ToDoLayout extends StatelessWidget {
  const ToDoLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ToDoCubit.get(context);
        return Form(
          key: global,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('ToDoApp'),
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add Task'),
                        content: defaultFormField(
                            controller: textController,
                            obscure: false,
                            keyboardType:TextInputType.text,
                            label: 'Task',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'You Should add task';
                              }

                            }
                        ),
                        actions: [
                          TextButton(
                              onPressed: (){
                                if(global.currentState!.validate()){
                                  cubit.insertIntoDatabase(task: textController.text);
                                  textController.clear();
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Add'
                              )
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                              )
                          ),
                        ],
                      );
                    });
              },
              tooltip: 'Add Task',
              child: const Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavigation(index);
              },
              items: cubit.bottomNavigationBarItem,
            ),
          ),
        );
      },
    );
  }
}
