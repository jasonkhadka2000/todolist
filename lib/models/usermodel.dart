class UserModel
{
  late String userName;
  late String email;
  late String password;

  UserModel(String userName,String email,String password)
  {
    this.userName=userName;
    this.email=email;
    this.password=password;
  }

  void trialDisplayDetails()
  {
    print(userName);
    print(email);
    print(password);
  }
}