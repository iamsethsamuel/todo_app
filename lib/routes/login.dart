// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/routes/signup.dart';
import 'package:todo_app/routes/homepage.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final Box<Map> box = Hive.box('user');
  final Box userBox = Hive.box('users');

  @override
  Widget build(BuildContext context) {
    return ScaffoldSkeleton(
      title: "Login",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _emailController,
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            CustomTextField(
              controller: _passwordController,
              hint: 'Password',
              obscureText: true,
            ),
            SizedBox(
              width: width(context),
              height: 50,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: TextButton(
                      child: const Text(
                        'Forgot Password',
                        textAlign: TextAlign.right,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: SizedBox(
                height: 55,
                child: Button(
                  text: 'Login',
                  onPressed: () async {
                    final List users = userBox.values.toList();
                    if (users.isEmpty) {
                      showSnackBar(context, 'No accounts found. Please signup');
                      return;
                    }

                    for (final user in users) {
                      if (user['email'] == _emailController.text &&
                          user['password'] == _passwordController.text) {
                        await box.put('user', user);
                        push(context, const HomePage());

                        return;
                      }
                    }

                    showSnackBar(context, 'Invalid username or password');
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(),
            ),
            Row(
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    push(context, const Signup());
                  },
                  child: const Text("Signup"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
