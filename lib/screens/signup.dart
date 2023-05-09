import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_authentication/providers/user_provider.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
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
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            SignUpForm(),
            backButton
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController fnameController = TextEditingController();
    TextEditingController lnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final fname = TextFormField(
        controller: fnameController,
        decoration: const InputDecoration(
          hintText: "First Name",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'First name is required!';
          }
          return null;
        });

    final lname = TextFormField(
        controller: lnameController,
        decoration: const InputDecoration(
          hintText: "Last Name",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Last name is required!';
          }
          return null;
        });

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

    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await context
                .read<AuthProvider>()
                .signUp(emailController.text, passwordController.text);
            await context.read<UserListProvider>().addUser(emailController.text,
                fnameController.text, lnameController.text);
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          fname,
          lname,
          email,
          password,
          SignupButton,
        ],
      ),
    );
  }
}
