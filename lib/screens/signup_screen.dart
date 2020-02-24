import 'package:cafeteria/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/spaced_column.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => new _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name, _surname, _studentId, _email, _password, _passwordRetype;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sign up'),
        ),
        body: new Container (
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
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required.';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters.';
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  }
                ),

                Container(
                  width: double.infinity,
                  child: RaisedButton(
                      child: Text('Sign up'),
                      onPressed: () {
                        signUp();
                      }),
                )],),
          ),
        ));
  }

  void signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        //user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } catch (e) {
          showSignupAlertDialog(context);
      }
    }
  }
}

  showSignupAlertDialog(BuildContext context) {
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
      title: Text("Warning"),
      content: Text("The email address is already in use by another account."),
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
