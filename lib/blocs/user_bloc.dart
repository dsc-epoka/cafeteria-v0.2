class UserBloc {
  final _users = {'': ''};

  void signUp(String email, String password) => _users[email] = password;

  /*void signIn() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email, password: _password);

      }
    }
  }*/
}
