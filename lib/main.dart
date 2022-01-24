import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttermanager/screens/public.dart';
import 'package:fluttermanager/services/userService.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ManageApp',
      home: StreamBuilder(
        stream: _userService.user,
          builder: (context, snapshot) {
          print(snapshot.connectionState);

          return Center(
            child: Text('Loading...'),
          );

      }),
    );
  }
  
}




