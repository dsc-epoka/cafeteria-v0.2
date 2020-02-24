import 'package:cafeteria/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/spaced_column.dart';
import '../widgets/tappable_text.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    //final _userBloc = Provider.of<UserBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sign in'),
        ),
        body: new Container(
            margin: EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: new Form(
              key: _formKey,
              child: SpacedInColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                spacer: SizedBox(height: 10),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field is required.';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    }
                    //controller: _emailController,

                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field is required.';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    }
                    //controller: _passwordController,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                        child: Row(
                          children: <Widget>[
                            //Icon(LineIcons.alternate_sign_in),
                            Spacer(),
                            Text('Sign in'),
                            Spacer(),
                          ],
                        ),
                        onPressed: () {
                          signIn();
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account yet?"),
                      TappableText(
                        'Sign up',
                        onPressed: () =>
                        //Navigator.pushReplacementNamed(context, '/signup'),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen())),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

 void signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
        /*AuthResult user = await*/
      try {
        FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } catch (e) {
          showLoginAlertDialog(context);
        }
      }
    }
}


showLoginAlertDialog(BuildContext context) {
  // Set up the button
  Widget okButton = FlatButton(
    child: Text("OK",
      style: TextStyle(
          color: Colors.blue
      ),
    ),

    onPressed: () {
      Navigator.of(context).pop(); // Dismiss dialog
     },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Invalid email or password."),
    actions: [
      okButton,
    ],
  );

  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}