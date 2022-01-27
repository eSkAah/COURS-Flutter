import 'package:flutter/material.dart';
import 'package:fluttermanager/models/userModel.dart';
import 'package:fluttermanager/screens/dashboard/Home.dart';
import 'package:fluttermanager/screens/public/Auth.dart';
import 'package:fluttermanager/screens/public/Term.dart';
import 'package:fluttermanager/screens/public/password.dart';
import 'package:fluttermanager/services/CommonService.dart';
import 'package:fluttermanager/services/userService.dart';

class PublicScreen extends StatefulWidget {
  const PublicScreen({Key? key}) : super(key: key);

  @override
  _PublicScreenState createState() => _PublicScreenState();
}

class _PublicScreenState extends State<PublicScreen> {
  final CommonService _commonService = CommonService();
  final UserService _userService = UserService();

  final List<Widget> _widgets = [];
  int _selectedIndex = 0;
  String _email = "";

  @override
  void initState() {
    super.initState();


    AuthScreen authScreen = AuthScreen(
        nextStep: (index, value) async {
          StateRegistration stateRegistration = await _userService.mailinglist(value);

          setState(() {
            _selectedIndex = index;
            _email = value;

            if(stateRegistration == StateRegistration.COMPLETE){
              _selectedIndex = _widgets.length -1;
            }
          });
        }
    );


    PasswordScreen passwordScreen = PasswordScreen(nextStep: (index, value) async {

      UserModel connectedUserModel = await _userService.auth(UserModel(
          email: _email,
          password: value, uid: ''),
      );

      setState(() {
        if (index != null){
          _selectedIndex = index;
        }

        if(connectedUserModel != null){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeScreen(),
            ),
          );
        }
      });
    },
    );

    _commonService.terms.then((terms) => setState(() => _widgets.addAll([
        authScreen,
        TermScreen(
            terms: terms,
            nextStep: (index) => setState(() => _selectedIndex = index)),
        passwordScreen,
      ]))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widgets.isEmpty ? const SafeArea(child: Scaffold(body: Center(child: Text('Loading...'),),)) : _widgets.elementAt(_selectedIndex),
    );
  }
}
