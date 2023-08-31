import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/routes/create_new_project.dart';
import 'package:todo_app/routes/login.dart';
import 'package:todo_app/utils/theme.dart';
import 'package:todo_app/widgets/TaskRange.dart';
import 'package:todo_app/widgets/Tasks.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String range = 'Day';
  String startDate = "";
  String endDate = "";
  ScrollDirection? taskScrollDirection;
  ScrollController taskScrollController = ScrollController();
  Box box = Hive.box('personality');
  final Box<Map> userBox = Hive.box('user');
  Map? user;

  void changeDateRange(String start, String end) {
    setState(() {
      startDate = start;
      endDate = end;
    });
  }

  void changeRange(String newRange) {
    setState(() {
      range = newRange;
    });

    if (newRange == 'Day') {
      final date = DateTime.now();
      final day = date.add(const Duration(hours: 24));
      changeDateRange(date.toIso8601String(), day.toIso8601String());
    }
  }

  @override
  void initState() {
    super.initState();
    taskScrollController.addListener(() {
      setState(() {
        taskScrollDirection = taskScrollController.position.userScrollDirection;
      });
    });
    user = userBox.get("user");
    user?.remove('password');
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldSkeleton(
      disenablePadding: true,
      title: '',
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              if (user != null)
                for (final u in user!.entries.toList())
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text("${u.key.toString().toUpperCase()}: ${u.value}",
                        style: bodyMedium(context)),
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    "Personality: ${box.get(user?['email'])}",
                    style:
                        bodyLarge(context)?.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              Button(
                  text: 'Log out',
                  onPressed: () {
                    userBox.clear().then((value) {
                      push(context, const Login());
                    });
                  })
            ],
          ),
        ),
      ),
      body: ColoredBox(
        color: AppColors.primary.withOpacity(.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TaskRange(
                    changeRange: changeRange,
                    range: range,
                    taskScrollDirection: taskScrollDirection),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Tasks',
                      style: headlineMedium(context)?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: height(context) - (height(context) / 4),
                width: width(context),
                child: Tasks(
                    startDate: startDate,
                    endDate: endDate,
                    range: range,
                    controller: taskScrollController),
              ),
            ],
          ),
        ),
      ),
      fab: FloatingActionButton(
        shape: const CircleBorder(),
        enableFeedback: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          push(context, const CreateProject());
        },
      ),
    );
  }
}
