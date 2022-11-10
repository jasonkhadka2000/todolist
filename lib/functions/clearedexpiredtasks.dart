import 'package:flutter/material.dart';
import 'package:todolist/models/taskmodel.dart';


List<Task> updateExpiredTasks(List<Task> task)
{
  for(int i=0;i<task.length;i++)
    {
      if((task[i].taskDeadline).difference(DateTime.now()).inMinutes<0)
        {
          task[i].taskStatus="Cancelled";
        }
      if((task[i].taskDeadline).difference(DateTime.now()).inMinutes<5)
        {
          task[i].deadlineWarning=true;
        }
    }
  return task;
}