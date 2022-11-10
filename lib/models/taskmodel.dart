class Task {
  late String taskName;
  late String taskImportance;
  late String taskStatus;
  late DateTime taskStartDate;
  late DateTime taskDeadline;
  late bool? deadlineWarning;

  Task(String taskName,String taskImportance,DateTime taskDeadLine)
  {
    this.taskName=taskName;
    this.taskImportance=taskImportance;
    this.taskDeadline=taskDeadLine;
    this.taskStatus="In progress";
    this.taskStartDate=DateTime.now();
    if(int.parse(taskDeadline.difference(DateTime.now()).inMinutes.toString())<5)
      {

        deadlineWarning=true;
      }
    else{
      deadlineWarning=false;
    }
    print(deadlineWarning);
  }

  void trailPrint()
  {
    print(taskName);
    print(taskStatus);
    print(taskImportance);
    print(deadlineWarning);
  }

  void activateDeadline()
  {
    this.deadlineWarning=true;
  }
}