import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermanager/screens/public.dart';
import 'package:fluttermanager/services/userService.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  final UserService _userService = UserService();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ManageApp',
      home: StreamBuilder(
        stream: _userService.user,
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.active){
            // ignore: avoid_print
            print(snapshot.hasData);

            return const PublicScreen();
          }

          return const SafeArea(
            child: Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
          ));
        },
      ),
    );
  }
  
}




