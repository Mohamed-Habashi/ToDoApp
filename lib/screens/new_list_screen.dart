import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/layout/cubit/todocubit.dart';
import 'package:to_do_app/layout/cubit/todostates.dart';

class NewListScreen extends StatelessWidget {
  const NewListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
        listener: (context,state){},
        builder: (context,state){
          return ToDoCubit.get(context).newTasks.isEmpty? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                Icons.home,
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
              itemBuilder: (context,index)=>showData(ToDoCubit.get(context).newTasks[index],context),
              separatorBuilder: (context,index)=>Container(height: 1,color: Colors.grey,),
              itemCount: ToDoCubit.get(context).newTasks.length
          );
        },
    );
  }
}

Widget showData(Map<String,dynamic>map,context){
  return Dismissible(
    key: Key(map['id'].toString()),
    direction: DismissDirection.endToStart,
    onDismissed: (value){
      ToDoCubit.get(context).deleteDatabase(id: map['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${map['status']}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${map['name']}',
                style: const TextStyle(
                  fontSize: 16
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                DateTime.now().toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              if(map['status']!='done')
                IconButton(
                  onPressed: (){
                    ToDoCubit.get(context).updateDatabase(status: 'done', id: map['id']);
                  },
                  icon: const Icon(
                    Icons.check_box,
                    color: Colors.grey,
                  )
              ),
              if(map['status']!='archive')
                IconButton(
                  onPressed: (){
                    ToDoCubit.get(context).updateDatabase(status: 'archive', id: map['id']);
                  },
                  icon: const Icon(
                    Icons.archive_outlined,
                  )
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
