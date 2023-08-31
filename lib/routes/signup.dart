import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/routes/login.dart';
import 'package:todo_app/routes/homepage.dart';
import 'package:todo_app/routes/questionaire.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailController = TextEditingController(),
      _nameController = TextEditingController(),
      _phoneController = TextEditingController(),
      _addressController = TextEditingController(),
      _companyController = TextEditingController(),
      _cPasswordController = TextEditingController(),
      _passwordController = TextEditingController();

  final Box<Map> box = Hive.box('user');
  final Box usersBox = Hive.box('users');

  @override
  Widget build(BuildContext context) {
    return ScaffoldSkeleton(
      title: "Sign Up",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _nameController,
                hint: 'Name',
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _phoneController,
                hint: 'Phone number',
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _emailController,
                hint: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _addressController,
                hint: 'Address',
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _companyController,
                hint: 'Company',
                keyboardType: TextInputType.text,
              ),
            ),
            CustomTextField(
              controller: _passwordController,
              hint: 'Password',
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _cPasswordController,
                hint: 'Confirm Password',
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: SizedBox(
                height: 55,
                child: Button(
                  text: 'Signup',
                  onPressed: () {
                    final user = {
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'email': _emailController.text,
                      'address': _addressController.text,
                      'company': _companyController.text,
                      'password': _passwordController.text
                    };
                    if (_emailController.text.isEmpty) {
                      showSnackBar(context, 'Email is required');
                      return;
                    }
                    if (_passwordController.text.isEmpty) {
                      showSnackBar(context, 'Password is required');
                      return;
                    }
                    if (_nameController.text.isEmpty) {
                      showSnackBar(context, 'Name is required');
                      return;
                    }

                    if (_passwordController.text != _cPasswordController.text) {
                      showSnackBar(context, "Passwords didn't match");
                      return;
                    }

                    usersBox.add(user);

                    box.put('user', user).then((value) {
                      push(context, const Questionaire());
                    }).catchError((err) {
                      print(err);
                      showSnackBar(context, 'Sorry an error occurred');
                    });
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
                const Text("Do you have an account? "),
                TextButton(
                  onPressed: () {
                    push(context, const Login());
                  },
                  child: const Text("Login"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
