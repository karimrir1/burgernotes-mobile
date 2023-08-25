import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => WelcomePage();
}

class WelcomePage extends State<Welcome> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: <Widget>[
        const Padding(padding: EdgeInsets.only(bottom: 200)),
        Container(
            child: const Text("burgernotes",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25))),
        Container(child: const Text("welcome to burgernotes!")),
        const Padding(padding: EdgeInsets.only(bottom: 50)),
        OutlinedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: const Text('log in'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signup()));
          },
          child: const Text("sign up"),
        )
      ])),
    );
  }
}
