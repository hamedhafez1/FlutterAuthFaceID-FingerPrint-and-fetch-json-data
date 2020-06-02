import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlocalauth/User.dart';
import 'package:http/http.dart' as http;

var url = "https://ware.uncox.com/api/profile/generate";

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<User> user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("صفحه کاربر"),
      ),
      backgroundColor: Colors.amber,
      body: Center(
          child: FutureBuilder<User>(
        future: user,
        builder: (context, user) {
          if (user.hasData) {
            return Column(
              children: <Widget>[
                Text(
                  user.data.firstName,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(user.data.lastName,
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(user.data.gender,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 24)),
                Text(user.data.email,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 24)),
//                Image.network('https:' + user.data.imageUrl),
                FadeInImage.assetNetwork(
                    placeholder: 'assets/spinner.gif',
                    image: 'https:' + user.data.imageUrl),
                Text(
                  user.data.phone,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            );
          } else if (user.hasError) {
            return Text("Error");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      )),
    );
  }
}

Future<User> fetchProfile() async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    var feeds = parsedJson['feeds'];
    var profile = feeds['profiles'];
    print(profile[0]);
    User user = User.fromJson(profile[0]);
    return user;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
