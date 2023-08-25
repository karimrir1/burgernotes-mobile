import 'package:burgernotes/notes.dart';
import 'package:flutter/material.dart';
import 'api/signup.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => SignupPage();
}

class SignupPage extends State<Signup> {
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  // String signup_error = "";
  /*
  void updateSignupError() {
    setState(() {
          
        });
  }
  */
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      Padding(padding: EdgeInsets.only(bottom: 200)),
      Container(
        child: const Text(
          "sign up",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
        ),
      ),
      /*
      Container(
      alignment: Alignment.centerLeft,
      child: Padding(padding: EdgeInsets.only(left: 10), child: Text("password", style: TextStyle(fontSize: 15),),)
      ),
      Padding(padding: EdgeInsets.only(top: 5),),
      */
      Container(
      width: 350,
        child: TextField(
          controller: usercontroller,
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            hintText: 'username (alphanumeric and max 20 characters)',
          ),
        ),
      ),
      Padding(padding: EdgeInsets.only(bottom: 35),),
      Container(
        width: 350,
        child: TextField(
          controller: passcontroller,
          decoration: InputDecoration(
            //border: (),
            hintText: 'password (minimum 14 characters)',
          ),
        ),
      ),
      Padding(padding: EdgeInsets.only(top: 1)),
      Text(
        error,
        style: TextStyle(color: Colors.red),
      ),
      Padding(padding: EdgeInsets.only(bottom: 25)),
      OutlinedButton(
          onPressed: ()  {
           signup(usercontroller.text, passcontroller.text);
           Navigator.push(context, MaterialPageRoute(builder: (context) => Notes()));
          },
          child: const Text("sign up")),
    ])));
  }
}
