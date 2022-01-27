import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final Function(int, String) nextStep;

  const AuthScreen({Key? key,
     required this.nextStep,}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange[500],
        body: Center(
          child:SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'IS IT TIME \n'.toUpperCase(),
                    style:  const TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0
                    ),
                    children: [
                      TextSpan(
                          text: 'TO TRAVEL ?\n'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      const TextSpan(
                          text: 'Login to know...\n',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                          )),
                    ],
                  )
                ),

                Form(
                  key: _formKey,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Enter your email address.', style: TextStyle(color: Colors.white),),
                      TextFormField(
                        validator: (value) => value!.isEmpty || !emailRegex.hasMatch(value) ? 'Wrong email format.' : null,
                        onChanged: (value) => setState(() => _email = value),
                        decoration: InputDecoration(
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
                                  color: Colors.white
                              )
                          )
                      ),),

                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: !emailRegex.hasMatch(_email)
                                ? null
                                : () {
                              if(_formKey.currentState!.validate()) {
                                widget.nextStep(1, _email);
                              }
                            },
                            child: const Text('CONNECT'),
                          ),
                        ],
                      ),
                    ],
                  )
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
