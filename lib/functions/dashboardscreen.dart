import 'package:flutter/material.dart';
import 'package:todolist/functions/clearedexpiredtasks.dart';
import 'package:todolist/functions/statistics.dart';
import 'package:todolist/models/taskmodel.dart';

class DashBoard extends StatefulWidget {
  late List<Task> tasks;
  late List<String> typeOfPriority;
  late List<String> typeOfStatus;

  DashBoard(List<Task> tasks,List<String> typeOfPriority,List<String> typeOfStatus)
  {
    this.tasks=tasks;
    this.typeOfPriority=typeOfPriority;
    this.typeOfStatus=typeOfStatus;
  }

  @override
  State<DashBoard> createState() => _DashBoardState(tasks,typeOfPriority,typeOfStatus);
}

class _DashBoardState extends State<DashBoard> {
  late List<Task> tasks;
  late List<String> typeOfPriority;
  late List<String> typeOfStatus;



  _DashBoardState(List<Task> tasks,List<String> typeOfPriority,List<String> typeOfStatus)
  {
    this.tasks=tasks;
    this.typeOfPriority=typeOfPriority;
    this.typeOfStatus=typeOfStatus;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tasks=updateExpiredTasks(tasks);
    });
  }
  Widget cardForPriority(List<Task> tasks,String priority)
  {

    int count=0;
    for(int i=0;i<tasks.length;i++)
    {
      if(tasks[i].taskImportance==priority)
      {
        count=count+1;
      }
    }
    return Expanded(
      flex:1,
      child: Card(
        margin: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.query_builder_sharp,
              color: priority==typeOfPriority[0]?Colors.red[900]:
              priority==typeOfPriority[1]?Colors.yellow[900]:
                Colors.green[900],

            ),
            Text(priority),
            Text("("+count.toString()+" remaining"+")"),
          ],
        ),
      ),
    );
  }

  Widget cardForStatus(List<Task> tasks,String status)
  {
    int count=0;
    for(int i=0;i<tasks.length;i++)
      {
        if(tasks[i].taskStatus==status)
          {
            count=count+1;
          }
      }
    return Expanded(
      flex:1,
      child: Card(
        margin: EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                status==typeOfStatus[0]?Icons.update:
              status==typeOfStatus[1]?Icons.cancel:
              Icons.verified,
              color: Colors.green[900],

            ),
            Text(status),
            Text("("+count.toString()+" remaining"+")"),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Expanded(
           flex:1,
           child: Row(
                children: typeOfStatus.map((status) =>cardForStatus(tasks,status)).toList(),
              ),
         ),
        Expanded(
          flex: 1,
          child: Row(
            children: typeOfPriority.map((priority) =>cardForPriority(tasks,priority)).toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children:[
              Expanded(
                flex: 1,
                child: Card(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          effciencyCount(tasks).toString()+"%",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                      Text("(efficiency)"),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        warningCount(tasks).toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      Text("Deadlines"),

                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tasks.length.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      Text("Total tasks"),

                    ],
                  ),
                ),
              ),


            ]
          ),
        ),
      ],
    );
  }
}
