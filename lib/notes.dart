import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api/notes.dart';

class Notes extends StatefulWidget {
  @override
  State<Notes> createState() => NotesPage();
}

Future<http.Response> userInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return http.post(
    Uri.parse('https://burger.ctaposter.xyz/api/userinfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'secretKey': prefs.getString('DONOTSHARE-secretkey').toString(),
    }),
  );
}

class NotesPage extends State<Notes> {
  /*
  String? notes;
  @override
  void initState() {
    super.initState();

    // fetchName function is a asynchronously to GET http data
    listNotes().then((result) {
      // Once we receive our name we trigger rebuild.
      setState(() {
        notes = result.toString();
      });
    });
  }
*/


  /*
  Future<String> getUsername() async {
    http.Response res = await userInfo();
    Map<String, dynamic> jsonRes = jsonDecode(res.body);
    return jsonRes["username"];
  }
  Future<int> getUsedStorage() async {
    http.Response res = await userInfo();
    Map<String, dynamic> jsonRes = jsonDecode(res.body);
    return jsonRes["storageused"];
  }
  */
  Future<(Future<String>, Future<int>, Future<String>)> getMaxStorage() async {
    http.Response res = await userInfo();
    Map<String, dynamic> jsonRes = jsonDecode(res.body);
    final String username = jsonRes["username"];
    final int usedStorage = jsonRes["storageused"];
    final String maxStorage = jsonRes["storagemax"];
    return (
      Future<String>.value(username),
      Future<int>.value(usedStorage),
      Future<String>.value(maxStorage)
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
    Widget condition() {
  
    // other logic  
    // Declare a widget variable,
    // it will be assigned later according
    // to the condition
    Widget widget = Text("");
  
    // Using switch statement to display desired
    // widget if any certain condition is met
    // You are free to use any condition
    // For simplicity I have used boolean contition
    if (snapshot.connectionState == ConnectionState.done) {
       if (snapshot.hasData) {
        widget = Text(snapshot.data);
      }
    else {
      print(snapshot.data);
      widget = Text("loading notes..");
    }
}

    // Finally returning a Widget
    return widget;
}
          return Scaffold(
              appBar: AppBar(
                // title: (snapshot.data.toString()),
                // leading: Icon(Icons.account_box),
                actions: [
                  IconButton(
                      onPressed: () async {
                        var (user, used, max) = await getMaxStorage();
                        Future<void> _showMyDialog() async {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('User'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('manage your account $user'),
                                      Text(
                                          'using ${used.toString()} out of ${max.toString()}'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Approve'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        _showMyDialog();
                      },
                      icon: Icon(Icons.account_box))
                ],
              ),
              body: Center(
              child: condition()
              ));
          // throw '';
        }


        );
  }
} // throw '';
