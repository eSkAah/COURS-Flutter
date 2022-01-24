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
        body: Center(
          child:SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Manage your \n'.toUpperCase(),
                    style:  const TextStyle(
                        color:Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0
                    ),
                    children: [
                      TextSpan(
                          text: 'business\n'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      TextSpan(
                        text: 'in a \n'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                          text: 'Different way\n\n'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      const TextSpan(
                          text: 'Login to continue...\n',
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
                      const Text('Enter your email address.'),
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
                                  color: Colors.grey
                              )
                          )
                      ),),

                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: !emailRegex.hasMatch(_email)
                                ? null
                                : () {
                              if(_formKey.currentState!.validate()) {
                                print(_email);
                                widget.nextStep(1, _email);
                              }
                            },
                            child: const Text('VALIDATE'),
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
