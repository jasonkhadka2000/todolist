import 'package:flutter/material.dart';
import 'package:todolist/models/usermodel.dart';
import 'package:todolist/navbar.dart';
import 'package:todolist/screens/dashboard.dart';
import 'package:todolist/screens/inprogress.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController email=TextEditingController();

  GlobalKey<FormState> _state = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/todolist.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _state,

                child: Container(
                  margin: EdgeInsets.all(40),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Let's go",
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Lobster",
                            fontWeight: FontWeight.w100,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      SizedBox(
                        height:12,
                      ),
                      TextFormField(
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Username is empty";
                        },
                        controller: userName,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:  BorderSide(color: Colors.amber, width: 2)
                          ),
                          hintText: 'Enter your username',
                          ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Email is empty";
                        },
                        controller: email,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:  BorderSide(color: Colors.amber, width: 2)
                          ),
                          hintText: 'Enter your email',
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Password is email";
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.amber, width: 2)
                          ),
                          hintText: 'Enter your password',
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: ()
                          {
                           if(_state.currentState!.validate())
                             {
                               UserModel user=UserModel(userName.text, email.text, password.text);
                               Navigator.of(context).push(
                                 MaterialPageRoute(
                                   builder: (context) => Home(user,[]),
                                 ),
                               );
                             }
                          },
                          child: Text("Login"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey ,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),

      ),
    );
  }
}

