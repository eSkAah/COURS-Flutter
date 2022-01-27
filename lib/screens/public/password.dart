import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  final Function(int, String) nextStep;

  const PasswordScreen({Key? key,
    required this.nextStep}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = "";
  bool _isSecret = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange[500],

        appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Colors.orange[500],
        elevation: 0.0,
        title: const Text('',
          style: TextStyle(
              color: Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => widget.nextStep(0, ''),
        )
        ),

        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0
            ),

            child: Column(
              children: [

                Text('Password'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 30.0,color: Colors.white, fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 50.0,
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Enter your password.', style: TextStyle(color: Colors.white),),
                      TextFormField(
                        onChanged: (value) => setState(() => _password = value),
                        validator: (value) => value!.length < 6 ? 'Password is too short' : null,
                        obscureText: _isSecret,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => setState(() => _isSecret = !_isSecret),
                            child: Icon(_isSecret ? Icons.visibility : Icons.visibility_off),
                          ),
                        hintText: 'ex: Ploki47915!',
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
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: _password.length < 6 ? null :  () {
                          if(_formKey.currentState!.validate()){
                            widget.nextStep(2 , _password);
                          }
                        },
                        child: const Text('VALIDATE'),
                      )
                    ],
                  )
                )
              ],
            ),
          )
        )
      ),
    );
  }
}
