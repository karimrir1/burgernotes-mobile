import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
  Future<http.Response> notesListRequest() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    return http.post(
      Uri.parse('https://burger.ctaposter.xyz/api/listnotes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'secretKey': prefs.getString('DONOTSHARE-secretkey').toString(),
      }),
    );
  }

Future<String> listNotes() async {
  http.Response res = await notesListRequest();   
  Future<String> notes = json.decode(res.body);
  print (res.body);
  return res.body;
}
