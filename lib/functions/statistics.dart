import 'package:todolist/models/taskmodel.dart';

double effciencyCount(List<Task> tasks)
{
  double eff=0;
  int completedCount=0;

  if(tasks.length==0)
    return 0.0;
  for(int i=0;i<tasks.length;i++)
    {
      if(tasks[i].taskStatus=="Completed")
      {
          completedCount=completedCount+1;
      }
    }
  eff=completedCount/tasks.length;
  return eff*100;


}

int warningCount(List<Task> tasks)
{
  int count=0;

  for(int i=0;i<tasks.length;i++)
  {
    print(tasks[i].deadlineWarning);
    if(tasks[i].deadlineWarning==true && tasks[i].taskStatus=="In progress")
    {
      count=count+1;
    }
  }
  return count;
}