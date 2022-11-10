import 'package:todolist/models/taskmodel.dart';

int countTypeoftask(List<Task> tasks,String taskType)
{
  int count=0;
  for(int i=0;i<tasks.length;i++)
  {
    if(tasks[i].taskStatus==taskType)
    {
      count=count+1;
    }
  }
  return count;
}

List<Task> specificStatusTask(List<Task> tasks,String status)
{
  List<Task> subTasks=[];
  for(int i=0;i<tasks.length;i++)
    {
      if(tasks[i].taskStatus==status)
        {
          subTasks.add(tasks[i]);
        }
    }
  return subTasks;
}

String convertMinutes(String minute)
{
  int m=int.parse(minute);
  if(m>=10)
    {
      return minute;
    }
  else{
    return "0"+minute;
  }
}
