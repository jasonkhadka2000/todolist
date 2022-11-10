import 'package:flutter/material.dart';
import 'package:todolist/functions/clearedexpiredtasks.dart';
import 'package:todolist/functions/count%20functions.dart';
import 'package:todolist/functions/toastmessage.dart';
import 'package:todolist/models/taskmodel.dart';
import 'package:todolist/models/usermodel.dart';
import 'package:todolist/navbar.dart';

class Cancelled extends StatefulWidget {

  late UserModel newUser;
  late List<Task> tasks;
  Cancelled(UserModel user,List<Task> tasks)
  {
    newUser=user;
    this.tasks=tasks;
  }

  @override
  State<Cancelled> createState() => _CancelledState(newUser,tasks);
}

class _CancelledState extends State<Cancelled> {
  late UserModel user;
  late List<Task> tasks;
  List<Task> cancelledTask=[];

  _CancelledState(UserModel newUser,List<Task> tasks)
  {
    user=newUser;
    this.tasks=tasks;
  }

  Widget toCard(Task task)
  {

    return Card(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Row(
              children: [
                Text(
                    task.taskName,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                  ),
                ),

                Row(
                  children: [
                    TextButton.icon(
                        onPressed: ()
                        {
                          setState(() {
                            tasks.remove(task);
                            cancelledTask=specificStatusTask(tasks, "Cancelled");
                            tasks=updateExpiredTasks(tasks);
                          });
                        },
                        icon: Icon(Icons.delete),
                        label: Text("Remove")
                    ),
                    TextButton.icon(
                      onPressed: ()
                      {
                        Duration diff=(task.taskDeadline).difference(DateTime.now());
                        if(int.parse(diff.inMinutes.toString())<0)
                        {
                          notifyUser("Deadline reached");
                          return;
                        }
                        setState(() {
                          task.taskStatus="In progress";
                          cancelledTask=specificStatusTask(tasks, "Cancelled");
                          tasks=updateExpiredTasks(tasks);
                        });
                      },
                      icon: Icon(Icons.timer),
                      label: Text("Back to queue"),
                    ),
                  ],
                ),

              ],
            ),

          ]
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tasks=updateExpiredTasks(tasks);
      cancelledTask=specificStatusTask(tasks, "Cancelled");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(user,tasks),
      appBar: AppBar(
        title: Text("Cancelled Task"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child:SingleChildScrollView(
          child: Column(
              children: cancelledTask.map((task) => toCard(task)).toList()
          ),
        ),
      ),
    );
  }
}
