import 'package:flutter/material.dart';
import 'welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notes.dart';

Future<String> isFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool a;
  if (prefs.containsKey('DONOTSHARE-secretkey') &&
      prefs.containsKey('DONOTSHARE-password')) {
    return Future<String>.value("false");
  } else {
    return Future<String>.value("true");
  }
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _getStartupScreen());
  }

  Widget _getStartupScreen() {
    return FutureBuilder<String>(
        future: isFirstTime(),
        builder: (context, AsyncSnapshot<String> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
           if (snapshot.data == 'true') {
            return Welcome();
          } else {
            print(isFirstTime().toString());
            print(snapshot.data);

            return Notes();
          }}
           return Text("u");
          // throw '';
        
        });
  }
}
