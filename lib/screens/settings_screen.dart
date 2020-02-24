import 'package:cafeteria/screens/initial_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../icons/line_icons.dart';

List<Widget> _themeOptions(
  BuildContext context, {
  Map<String, ThemeMode> items,
}) {
  final _themeMode = Provider.of<ValueNotifier<ThemeMode>>(context);
  final _widgets = <Widget>[];

  items.forEach(
    (title, themeMode) {
      _widgets.add(
        RadioListTile(
          activeColor: Theme.of(context).accentColor,
          title: Text(title),
          secondary: title == 'Dark' ? Icon(LineIcons.moon) : null,
          value: themeMode,
          groupValue: _themeMode.value,
          onChanged: (ThemeMode themeMode) => _themeMode.value = themeMode,
        ),
      );
    },
  );

  return _widgets;
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Theme'),
          ),
          ..._themeOptions(
            context,
            items: {
              'System default': ThemeMode.system,
              'Light': ThemeMode.light,
              'Dark': ThemeMode.dark,
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    //Icon(LineIcons.alternate_sign_out),
                    Spacer(),
                    Text('Sign out'),
                    Spacer(),
                  ],
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    //Navigator.of(context).pushReplacementNamed('/initial');
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => InitialScreen()));
                  }).catchError((e) {
                    print(e);
                  });
                  /*Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => InitialScreen()));
                  */}),
          ),
        ],
      ),
    );
  }
}
