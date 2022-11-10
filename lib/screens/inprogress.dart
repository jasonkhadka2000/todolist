import 'package:flutter/material.dart';
import 'package:todolist/functions/clearedexpiredtasks.dart';
import 'package:todolist/functions/count%20functions.dart';
import 'package:todolist/functions/datetimechoice.dart';
import 'package:todolist/functions/toastmessage.dart';
import 'package:todolist/models/taskmodel.dart';
import 'package:todolist/models/usermodel.dart';
import 'package:todolist/navbar.dart';

class InProgress extends StatefulWidget {
  late UserModel newUser;
  late List<Task> tasks;
  InProgress(UserModel user,List<Task> tasks)
  {
    this.tasks=tasks;
    newUser=user;
  }

  @override
  State<InProgress> createState() => _InProgressState(newUser,tasks);
}

class _InProgressState extends State<InProgress> {
  late UserModel user;
  late List<Task> tasks;
  late List<Task> inProgressTasks;
  _InProgressState(UserModel newUser,List<Task> tasks)
  {
    this.tasks=tasks;
    user=newUser;
  }

  //variables for editing any task
  int _value=0;
  List<String> typeOfPriority=["High priority","Medium priority","Low priority"];
  DateTime now=DateTime.now();
  bool deadlineWarning=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tasks=updateExpiredTasks(tasks);
      inProgressTasks=specificStatusTask(tasks, "In progress");
    });
    print(inProgressTasks);
  }

  Widget toCard(Task task)
  {
    DateTime currentTime=DateTime.now();
    Duration diff=(task.taskDeadline).difference(currentTime);
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2.0),
                margin: const EdgeInsets.all(2.0),
                child: Text(
                  task.taskName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "(${task.taskImportance})",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                  Row(
                    children: [
                      Icon(
                          Icons.timer,
                        color: int.parse(diff.inMinutes.toString())<5?Colors.red:Colors.blue,
                      ),
                      Text(diff.inMinutes.toString()+"m"),
                    ],
                  ),

                  Row(
                    children: [
                      TextButton(
                          onPressed: ()=> _displayDialog(context,tasks,task),
                          child: Text("Edit"),
                      ),
                      TextButton(
                          onPressed:()
                          {
                            setState(() {
                              task.taskStatus="Completed";
                              inProgressTasks=specificStatusTask(tasks, "In progress");
                              tasks=updateExpiredTasks(tasks);
                              notifyUser("Task completed");
                            });
                          },
                          child: Text("Mark as complete"),
                      ),
                      TextButton(
                        onPressed:()
                        {
                          setState(() {
                            task.taskStatus="Cancelled";
                            inProgressTasks=specificStatusTask(tasks, "In progress");
                            tasks=updateExpiredTasks(tasks);
                            notifyUser("Task cancelled");
                          });
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
            ],
          )

        ],
      ),
    );
  }

  //edit form for a task
  _displayDialog(BuildContext context,List<Task> tasks,Task task) async {
    Task copyTask=task;
    TextEditingController taskName=TextEditingController();
    taskName.text=task.taskName;

    return showDialog(
        context: context,
        builder: (context)=>StatefulBuilder(
            builder: (context, setState) =>
                AlertDialog(
                  title:Text("Time to work"),
                  content: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Task Name",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: taskName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()
                              ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Task Priority",
                          ),
                          Column(
                            children:[
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _value,
                                    onChanged: (value){
                                      print("tapped");
                                      setState((){

                                        _value=value as int;
                                      });
                                    },
                                  ),
                                  TextButton(
                                      child:Text(typeOfPriority[0]),
                                    onPressed: ()
                                    {
                                      _value=1;
                                    },
                                  ),
                                ],
                              ),


                              Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: _value,
                                    onChanged: (value){
                                      print("tapped");
                                      setState((){
                                        _value=value as int;
                                      });
                                    },
                                  ),
                                  TextButton(
                                    child:Text(typeOfPriority[1]),
                                    onPressed: ()
                                    {
                                      _value=2;
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue: _value,
                                    onChanged: (value){
                                      print("tapped");
                                      setState((){
                                        _value=value as int;
                                      });
                                    },
                                  ),
                                  TextButton(
                                    child:Text(typeOfPriority[2]),
                                    onPressed: ()
                                    {
                                      _value=3;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // TextButton.icon(onPressed: onPressed, icon: icon, label: label)
                              TextButton.icon(
                                onPressed: ()async
                                {
                                  var onlyDate=await pickDate(context);
                                  if(onlyDate==null) return;
                                  setState(() {
                                    now=onlyDate;
                                    print(now);
                                  });

                                },
                                label: Text('${now.year}/${now.month}/${now.day}'),
                                icon: Icon(Icons.date_range),
                              ),
                              TextButton.icon(
                                onPressed: () async
                                {
                                  TimeOfDay? onlyTime= await pickTime(context);
                                  if(onlyTime==null) return;
                                  DateTime newTime=DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    onlyTime.hour,
                                    onlyTime.minute,
                                  );
                                  setState(() {
                                    now=newTime;
                                    print(now);
                                    if(now.difference(DateTime.now()).inDays==0){
                                      if ((now.hour * 60 + now.minute) <
                                          (DateTime.now().hour * 60 +
                                              DateTime.now().minute)) {
                                        deadlineWarning = true;
                                      } else {
                                        deadlineWarning = false;
                                      }
                                    }
                                    print(deadlineWarning);
                                  });
                                },
                                label: Text("${now.hour}:"+convertMinutes(now.minute.toString())),
                                icon: Icon(Icons.timer),
                              ),
                            ],
                          ),
                          Container(
                            child: deadlineWarning?
                            Text(
                              "you entered old time",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ) :null,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: ()
                                  {

                                    Task newTask=Task(taskName.text,typeOfPriority[_value-1],now);
                                    setState(() {
                                      tasks.remove(task);
                                      tasks.add(newTask);
                                      tasks=updateExpiredTasks(tasks);
                                      inProgressTasks=specificStatusTask(tasks, "In progress");
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => InProgress(user,tasks),
                                      ),
                                    );
                                  },
                                  child: Text("Edit"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ) ,
                )
        ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(user,tasks),
      appBar: AppBar(
        title: Text("In progress tasks"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child:SingleChildScrollView(
          child: Column(
            children: inProgressTasks.map((task) => toCard(task)).toList()
          ),
        ),
      ),
    );
  }
}
