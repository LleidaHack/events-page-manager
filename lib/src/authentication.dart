import 'package:flutter/material.dart';

import 'widgets.dart';

enum ApplicationLoginState {
  loggedOut,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    required this.loginState,
    required this.email,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.signOut,
  });

  final ApplicationLoginState loginState;
  final String? email;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    if (this.loginState == ApplicationLoginState.loggedOut) {
      return Row(
        children: [
          LoginForm(login: (email, password) {
            signInWithEmailAndPassword(email, password,
                    (e) => _showErrorDialog(context, 'Failed to sign in', e));
          })
        ],
      );
    } else if (this.loginState == ApplicationLoginState.loggedIn) {
      return Row(children: [
        //NoticeManager();
      ]);

    }
    return Row(children: []);
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.login,
  });

  final void Function(String email, String password) login;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Header('Sign in'),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 260,
                height: 60,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your email address to continue';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 260,
                height: 60,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 16),
                    StyledButton(
                      onPressed: () {
                        widget.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      child: const Text('SIGN IN'),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
