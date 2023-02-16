import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/cubit/todocubit.dart';
import '../layout/cubit/todostates.dart';
import 'new_list_screen.dart';

class ArchiveListScreen extends StatelessWidget {
  const ArchiveListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context,state){},
      builder: (context,state){
        return ToDoCubit.get(context).archiveTasks.isEmpty? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.archive,
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
            itemBuilder: (context,index)=>showData(ToDoCubit.get(context).archiveTasks[index],context),
            separatorBuilder: (context,index)=>Container(height: 1,color: Colors.grey,),
            itemCount: ToDoCubit.get(context).archiveTasks.length
        );
      },
    );
  }
}
