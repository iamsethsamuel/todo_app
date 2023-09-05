import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/routes/homepage.dart';
import 'package:todo_app/utils/theme.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class QuestionaireResponse extends StatelessWidget {
  const QuestionaireResponse(
      {super.key,
      required this.box,
      required this.opacity,
      required this.response,
      this.user});
  final Box box;
  final double opacity;
  final Map<String, int> response;
  final Map? user;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: ListView(
        children: [
          Center(
            child: Text(
              'Your personality type is: ',
              textAlign: TextAlign.center,
              style: headlineLarge(context),
            ),
          ),
          if (response.keys.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  response.keys.first,
                  style: headlineLarge(context)?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Button(
              text: 'Go to Home',
              onPressed: () {
                box
                    .put(user!['email'], response.entries.first.key)
                    .then((value) {
                  push(context, const HomePage());
                }).catchError((err) {
                  showSnackBar(context, 'Sorry an error occurred');
                  print(err);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
