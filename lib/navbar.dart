import 'package:flutter/material.dart';
import 'package:todolist/models/taskmodel.dart';
import 'package:todolist/models/usermodel.dart';
import 'package:todolist/screens/cancelled.dart';
import 'package:todolist/screens/completed.dart';
import 'package:todolist/screens/dashboard.dart';
import 'package:todolist/screens/inprogress.dart';

class NavBar extends StatefulWidget {
  late UserModel newUser;
  late List<Task> tasks;

  NavBar(UserModel user,List<Task> tasks)
  {
    newUser=user;
    this.tasks=tasks;
  }

  @override
  State<NavBar> createState() => _NavBarState(newUser,tasks);
}

class _NavBarState extends State<NavBar> {
  final List<String> typesOfTask=["In progress","Cancelled","Completed"];
  late UserModel user;
  late List<Task> tasks;
  _NavBarState(UserModel newUser,List<Task> tasks)
  {
    user=newUser;
    this.tasks=tasks;
  }

  Widget TaskMenu(String task)
  {
    if(task=="In progress")
      {
        return ListTile(
          leading: Icon(
            Icons.update,
          ),
          title: Text(task),
          onTap: ()
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InProgress(user,tasks),
              ),
            );
          },
        );
      }
    else if(task=="Cancelled")
      {
        return ListTile(
          leading: Icon(
            Icons.dangerous,
          ),
          title: Text(task),
          onTap: ()
          {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>Cancelled(user,tasks),
              ),
            );
          },
        );
      }
    else{
      return ListTile(
        leading: Icon(
          Icons.verified,
        ),
        title: Text(task),
        onTap: ()
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Completed(user,tasks),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
              accountName: Text(user.userName),
              accountEmail: Text(user.email),
              currentAccountPicture:CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    "assets/dummyuser.png",
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ),

          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: Text("Dashboard"),
            onTap: ()
            {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Home(user,tasks),
                ),
              );
            },
          ),

          Column(
            children: typesOfTask.map((task) => TaskMenu(task)).toList()
          ),
        ],
      ),
    );
  }
}
