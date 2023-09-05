import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/routes/homepage.dart';
import 'package:todo_app/routes/login.dart';
import 'package:todo_app/utils/theme.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/QuestionaireResponse.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class Questionaire extends StatefulWidget {
  const Questionaire({super.key});

  @override
  State<Questionaire> createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  final Map<String, int> responses = {
    'The Perfectionist': 0,
    'The Creative avoider': 0,
    'The Pleasure seeker': 0
  };
  final Map<String, int> options = {
    'Strongly agree': 2,
    'Neutral': 1,
    'Strongly disagree': 0
  };

  int currQuestionIndex = 0;
  late Map question;
  Map<String, int> response = {};
  Box box = Hive.box('personality');
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  final Box<Map> userBox = Hive.box('user');
  Map? user;
  final Map<String, int> obj = {};

  @override
  void initState() {
    question = questions[currQuestionIndex];
    user = userBox.get("user");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSkeleton(
        title: 'Personality Questionaire',
        body: user == null
            ? Button(
                text: 'Please Login',
                onPressed: () {
                  push(context, const Login());
                })
            : PageView(
                children: [
                  if (response.keys.isEmpty)
                    AnimatedOpacity(
                      opacity: response.keys.isEmpty ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: AnimatedCrossFade(
                              firstChild: Text(
                                question['question'].toString(),
                                textAlign: TextAlign.center,
                                style: headlineLarge(context)?.copyWith(),
                              ),
                              secondChild: Text(
                                questions[currQuestionIndex == 0
                                        ? 0
                                        : currQuestionIndex + 1 <
                                                questions.length
                                            ? currQuestionIndex + 1
                                            : questions.length - 1]
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: headlineLarge(context)?.copyWith(),
                              ),
                              duration: const Duration(milliseconds: 500),
                              crossFadeState: crossFadeState,
                            ),
                          ),
                          for (final option in options.keys)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextButton(
                                onPressed: () {
                                  final val = int.parse(
                                    responses[question['type']!].toString(),
                                  );
                                  responses[question['type']!] =
                                      val + (options[option] as int);

                                  setState(() {
                                    if (currQuestionIndex + 1 <
                                        questions.length) {
                                      currQuestionIndex += 1;
                                      question = questions[currQuestionIndex];
                                      crossFadeState = CrossFadeState.showFirst;
                                    }
                                    if (currQuestionIndex >= questions.length) {
                                      return;
                                    }
                                  });
                                },
                                child: Text(
                                  option,
                                  style: headlineSmall(context)
                                      ?.copyWith(color: AppColors.primary),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              '${currQuestionIndex + 1}/${questions.length}',
                              style: headlineSmall(context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (currQuestionIndex >= questions.length - 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Button(
                                  text: 'Submit',
                                  onPressed: () {
                                    response[responses.keys.first] =
                                        responses.values.first;

                                    responses.forEach((key, value) {
                                      if (value > response.values.first) {
                                        obj[key] = value;
                                      }
                                    });

                                    setState(() {
                                      response = obj;
                                    });
                                  }),
                            )
                        ],
                      ),
                    ),
                  QuestionaireResponse(
                    box: box,
                    opacity: currQuestionIndex >= questions.length - 1 ? 1 : 0,
                    response: response,
                    user: user,
                  )
                ],
              ));
  }
}
