import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hashlib/hashlib.dart';

String error = "";

void login(String username, String password) async {
  final hashpass = Argon2(
    type: Argon2Type.argon2id,
    hashLength: 32,
    iterations: 256,
    parallelism: 1,
    memorySizeKB: 512,
    salt: sha512sum(password).codeUnits,
  );

  Future<http.Response> createUser(String name, String pass) async {
    return http.post(
      Uri.parse('https://burger.ctaposter.xyz/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': name,
        'password': await hashpass.encode(pass.codeUnits)
      }),
    );
  }

  http.Response res = await createUser(username, password);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (res.statusCode == 200) {
    Map<String, dynamic> jsonRes = jsonDecode(res.body);
    print(jsonRes["key"]);
    print(res.body);
    prefs.setString('DONOTSHARE-secretkey', jsonRes["key"]);
    prefs.setString('DONOTSHARE-password', sha512sum(password));
  } else if (res.statusCode == 401) {
    error = "wrong username or password :(";
  } else {
    error = "something went wrong! (error code ${res.statusCode})";
  }

  // print(hashedpass);
}
