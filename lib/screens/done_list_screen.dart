import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/cubit/todocubit.dart';
import '../layout/cubit/todostates.dart';
import 'new_list_screen.dart';

class DoneListScreen extends StatelessWidget {
  const DoneListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context,state){},
      builder: (context,state){
        return ToDoCubit.get(context).doneTasks.isEmpty? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.done,
                size: 100,
                color: Colors.grey.withOpacity(0.5),
              ),
              Text(
                'There is no tasks here ',
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),

                ),
              ),
            ],
          ),
        ): ListView.separated(
            itemBuilder: (context,index)=>showData(ToDoCubit.get(context).doneTasks[index],context),
            separatorBuilder: (context,index)=>Container(height: 1,color: Colors.grey,),
            itemCount: ToDoCubit.get(context).doneTasks.length
        );
      },
    );
  }
}
