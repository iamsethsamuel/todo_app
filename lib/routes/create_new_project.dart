import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

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

  @override
  Widget build(BuildContext context) {
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
                keyboardType: TextInputType.phone,
                maxLines: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(
                controller: _tagsController,
                hint: 'Tags: eg. work, important, boss',
                keyboardType: TextInputType.emailAddress,
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
                      showSnackBar(context, 'Project Created Successfully');
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
