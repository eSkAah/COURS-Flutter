import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 RichText(
                  text: TextSpan(
                    text: 'Don\'t waste your \n'.toUpperCase(),
                    style:  const TextStyle(
                      color:Colors.black87,
                      fontSize: 30.0
                  ),
                  children: [
                    TextSpan(
                         text: 'TIME\n'.toUpperCase(),
                         style: TextStyle(
                           color: Theme.of(context).primaryColor,
                           fontWeight: FontWeight.bold,
                         )
                     ),
                    TextSpan(
                       text: 'ANYMORE\n\n'.toUpperCase(),
                       style: const TextStyle(
                         color: Colors.black87,
                         fontWeight: FontWeight.bold,
                       )
                     ),
                    const TextSpan(
                          text: 'Login to continue...\n',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic
                     )),

                  ],

                  )
                ),
                const SizedBox(
                  height: 50.0,
                ),

                Form(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Enter your email address.'),
                        TextFormField(decoration: InputDecoration(
                          hintText: 'ex: john.doe@domain.top',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey
                              ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: const BorderSide(
                                color: Colors.grey
                            )
                          )
                        ),)
                      ],
                    ) )
              ],


            ),
          ),
        ),
      ),
    );
  }
}
