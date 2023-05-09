import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
        },
        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            LoginForm(),
            signUpButton,
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final email = TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          hintText: "Email",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required!';
          } else if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Invalid email address.';
          }
          return null;
        });

    final password = TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Password',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required!';
          } else if (value.length < 6) {
            return 'Password must be at least 6 characters.';
          }
          return null;
        });

    final loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await context.read<AuthProvider>().signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
          }
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          email,
          password,
          loginButton,
        ],
      ),
    );
  }
}
