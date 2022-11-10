import 'package:flutter/material.dart';
import 'package:todolist/functions/clearedexpiredtasks.dart';
import 'package:todolist/functions/count%20functions.dart';
import 'package:todolist/models/taskmodel.dart';
import 'package:todolist/models/usermodel.dart';
import 'package:todolist/navbar.dart';

class Completed extends StatefulWidget {
  late UserModel newUser;
  late List<Task> tasks;
  Completed(UserModel user,List<Task> tasks)
  {
    newUser=user;
    this.tasks=tasks;
  }

  @override
  State<Completed> createState() => _CompletedState(newUser,tasks);
}

class _CompletedState extends State<Completed> {
  late UserModel user;
  late List<Task> tasks;
  List<Task> completedTask=[];

  _CompletedState(UserModel newUser,List<Task> tasks)
  {
    this.tasks=tasks;
    user=newUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tasks=updateExpiredTasks(tasks);
    completedTask=specificStatusTask(tasks, "Completed");
  }

  Widget toCard(Task task)
  {

    return Card(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.taskName.toUpperCase(),
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  ),
                ),
              TextButton.icon(
                  onPressed: ()
                  {
                    setState(() {
                      tasks.remove(task);
                      completedTask=specificStatusTask(tasks, "Completed");
                      tasks=updateExpiredTasks(tasks);
                    });
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Remove")),
            ],
          ),

        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(user,tasks),
      appBar: AppBar(
        title: Text("Completed Task"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child:SingleChildScrollView(
          child: Column(
              children: completedTask.map((task) => toCard(task)).toList()
          ),
        ),
      ),
    );
  }
}

