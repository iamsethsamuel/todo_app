import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/routes/homepage.dart';
import 'package:todo_app/routes/login.dart';
import 'package:todo_app/routes/questionaire.dart';
import 'package:todo_app/widgets/customwidgets.dart';
import 'package:todo_app/utils/theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todos');
  await Hive.openBox('personality');
  await Hive.openBox<Map>('user');
  await Hive.openBox('users');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foqus',
      theme: appTheme(),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final Box<Map> userBox = Hive.box('user');
  Map? user;

  @override
  void initState() {
    
      setState(() {
        user = userBox.get('user');
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSkeleton(
      body: user == null ? const WelcomePage() : const HomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset('assets/images/atk one2.png'),
        SizedBox(
          width: width(context),
          height: 50,
          child: Button(
            onPressed: () {
              push(context, const Login());
            },
            text: 'Get Started',
          ),
        )
      ],
    );
  }
}
