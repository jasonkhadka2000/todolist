import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/functions/clearedexpiredtasks.dart';
import 'package:todolist/functions/count%20functions.dart';
import 'package:todolist/functions/dashboardscreen.dart';
import 'package:todolist/functions/datetimechoice.dart';
import 'package:todolist/functions/toastmessage.dart';
import 'package:todolist/models/taskmodel.dart';
import 'package:todolist/models/usermodel.dart';
import 'package:todolist/navbar.dart';
import 'package:todolist/screens/login.dart';



class Home extends StatefulWidget {

  late UserModel newUser;
  late List<Task> tasks;
  Home(UserModel user,List<Task> tasks)
  {
    this.tasks=tasks;
    newUser=user;
  }

  @override
  State<Home> createState() => _HomeState(newUser,tasks);
}

class _HomeState extends State<Home> {

  //all the variables declaration
  late UserModel user;
  late List<Task> tasks;
  _HomeState(UserModel newUser,List<Task> tasks)
  {
    this.tasks=tasks;
    user=newUser;
  }

  int completedTask=0;
  int inProgressTask=0;
  int cancelledTask=0;
  DateTime now=DateTime.now();
  List<String> typeOfPriority=["High priority","Medium priority","Low priority"];
  List<String> typeOfStatus=["In progress","Cancelled","Completed"];
  int _value=0;
  bool deadlineWarning =false;

  //radio buttons for priority
  Widget toRadioButton(String priority)
  {
    int value1=0;
    for(int i=0;i<typeOfPriority.length;i++)
      {
        if(typeOfPriority[i]==priority)
          {
            value1=i+1;
            break;
          }
      }
    print("toradio called");
    print(value1);
    return Row(
      children: [
        Radio(
            value: value1,
            groupValue:_value,
            onChanged:(value)
            {
              setState(() {
                _value=value as int;
              });

            }
        ),
        Text(priority),
      ],
    );
  }


  //this is the alert dialogue form for new task
_displayDialog(BuildContext context) async {
  TextEditingController taskName=TextEditingController();
  GlobalKey<FormState> _state = GlobalKey<FormState>();


  return showDialog(
      context: context,
      builder: (context)=>StatefulBuilder(
      builder: (context, setState) =>
          AlertDialog(
            title:Text("Time to work"),
            content: SingleChildScrollView(
              child: Form(
                key: _state,
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
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Task is empty";
                      },
                      controller: taskName,
                      decoration: InputDecoration(
                          hintText: "Describe you task",
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
                                setState((){
                                  _value=1;
                                });
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
                                setState((){
                                  _value=2;
                                });
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
                                setState((){
                                  _value=3;
                                });
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Deadline",
                    ),

                    //datetime inputting
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
                              if((now.hour*60+now.minute)<(DateTime.now().hour*60+DateTime.now().minute))
                              {
                              deadlineWarning=true;
                              }
                              else{
                              deadlineWarning=false;
                              }
                          }
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
                              if(_state.currentState!.validate() && deadlineWarning==false && _value!=0)
                                {
                                  addNewTask(taskName.text,typeOfPriority[_value-1],now);
                                  Navigator.of(context).pop();
                                  notifyUser("New task added succuessfully");
                                }
                              print(tasks);
                            },
                            child: Text("Add task")
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextButton(
                            onPressed: ()
                            {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel")
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ) ,
          )
      ));
    
}

  void updateTaskCounts()
  {
    setState(() {
      completedTask=countTypeoftask(tasks, "Completed");
      inProgressTask=countTypeoftask(tasks, "In progress");
      cancelledTask=countTypeoftask(tasks, "Cancelled");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTaskCounts();
    tasks=updateExpiredTasks(tasks);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: NavBar(user,tasks),
        appBar: AppBar(
          title: Text("Todo list app"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Container(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                  "Let's work "+user.userName,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              side: BorderSide(
                                width: 1.5,
                                color: Colors.amberAccent,
                              ),
                            ),
                            onPressed: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                          },
                            child: Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child:Container(
                      child:DashBoard(tasks,typeOfPriority,typeOfStatus),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> _displayDialog(context),
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
        ),
      ),
    );
  }

  void addNewTask(String taskName,String taskPriority,DateTime expDate)
  {
    Task newTask=Task(taskName, taskPriority, expDate);
    print(taskPriority);
    setState(() {
      tasks.add(newTask);
      updateTaskCounts();
      tasks=updateExpiredTasks(tasks);
    });
  }

}
