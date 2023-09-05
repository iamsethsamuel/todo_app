// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/routes/homepage.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class CreateProject extends StatefulWidget {
  const CreateProject(
      {super.key, required this.personalityBox, required this.user});
  final Box personalityBox;
  final Map? user;

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final _descriptionController = TextEditingController(),
      _nameController = TextEditingController(),
      _tagsController = TextEditingController(),
      _dueDateController = TextEditingController();

  TimeOfDay? time = TimeOfDay.now();
  DateTime? date = DateTime.now();
  Box box = Hive.box('todos');
  Box personalityBox = Hive.box('personality');

  @override
  Widget build(BuildContext context) {
    final suggestions =
        personalitySuggestions[personalityBox.get(widget.user!['email'])]!;

    return ScaffoldSkeleton(
      title: "Create New Task",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _nameController,
                hint: 'Project Name ',
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _descriptionController,
                hint: 'Project Description',
                textCapitalization: TextCapitalization.sentences,
                maxLines: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _tagsController,
                hint: 'Tags: eg. work, important, boss',
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _dueDateController,
                hint: 'Due date',
                keyboardType: TextInputType.emailAddress,
                onTap: () {
                  setState(() async {
                    time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    date = await showDatePicker(
                      initialDatePickerMode: DatePickerMode.day,
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: date?.add(
                            const Duration(days: 100000),
                          ) ??
                          DateTime.now(),
                    );
                    final dateIso = date?.toIso8601String();
                    _dueDateController.text =
                        '${dateIso?.substring(0, dateIso.lastIndexOf('T'))} ${time?.hour}:${time?.minute}:00.338956';
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: SizedBox(
                height: 55,
                child: Button(
                  text: 'Create Project',
                  onPressed: () {
                    // push(context, const HomePage());
                    box.add({
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'tags': _tagsController.text,
                      'due': _dueDateController.text
                    }).then((value) {
                      showSnackBar(
                          context,
                          ListView(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "You have successfully created a new project",
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Here are some strong suggestions specially created to help you stay focused on this project",
                                ),
                              ),
                              if (widget.user != null)
                                for (int i = 0; i < suggestions.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: suggestions[i].contains('\n')
                                        ? Wrap(
                                            children: [
                                              Text(
                                                '${i + 1}. ${suggestions[i].substring(0, suggestions[i].indexOf('\n') - 1)}',
                                              ),
                                              for (final suggestion
                                                  in suggestions[i]
                                                      .substring(
                                                        suggestions[i]
                                                            .indexOf('\n'),
                                                      )
                                                      .split('\n'))
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                    bottom: 10,
                                                  ),
                                                  child: Text(suggestion),
                                                )
                                            ],
                                          )
                                        : Text(
                                            "${i + 1}. ${suggestions[i]}",
                                          ),
                                  )
                            ],
                          ),
                          duration: const Duration(days: 1));
                      push(context, const HomePage());
                    }).catchError((err) {
                      print(err);
                      showSnackBar(context, 'An error occurred');
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
