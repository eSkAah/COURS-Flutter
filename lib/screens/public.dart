import 'package:flutter/material.dart';
import 'package:fluttermanager/models/userModel.dart';
import 'package:fluttermanager/screens/dashboard/Home.dart';
import 'package:fluttermanager/screens/public/Auth.dart';
import 'package:fluttermanager/screens/public/Term.dart';
import 'package:fluttermanager/screens/public/password.dart';
import 'package:fluttermanager/services/userService.dart';

class PublicScreen extends StatefulWidget {
  const PublicScreen({Key? key}) : super(key: key);

  @override
  _PublicScreenState createState() => _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  final UserService _userService = UserService();

  final List<Widget> _widgets = [];
  int _selectedIndex = 0;
  String _email = "";

  @override
  void initState() {
    super.initState();

    _widgets.addAll([
      AuthScreen(nextStep: (index, value) => setState(() {
        _selectedIndex = index;
        _email = value;
      })),
      TermScreen(nextStep: (index) => setState(() => _selectedIndex = index)),
      PasswordScreen(nextStep: (index, value) => setState(() {
        if (index != "") {
          _selectedIndex = index;
        }
        if (value != "") {
          _userService.auth(UserModel(email: _email, password: value, uid: ''))
            .then((value) {
              if(value.uid != null) {
                //2eme possibilité de navigation avec Navigator
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            }
          );
        }
      })),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.elementAt(_selectedIndex),
    );
  }
}
