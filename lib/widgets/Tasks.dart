import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shammo/shammo.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class Tasks extends StatefulWidget {
  const Tasks({
    super.key,
    required this.endDate,
    required this.startDate,
    required this.range,
    required this.controller,
    required this.user,
    required this.personalityBox,
  });
  final String startDate;
  final String endDate;
  final String range;
  final ScrollController controller;
  final Map? user;
  final Box personalityBox;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool showSuggestions = false;
  late String startDate;
  late String endDate;
  late String range;
  late ScrollController controller;

  @override
  void initState() {
    startDate = widget.startDate;
    endDate = widget.endDate;
    range = widget.range;
    controller = widget.controller;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = personalitySuggestions[
        widget.personalityBox.get(widget.user!['email'])]!;

    bool calcDays(element, int duration) {
      final d = dateDifference(element['due'].toString());
      if (d.contains('hours')) {
        return true;
      }

      if (!d.contains('days')) {
        return false;
      }

      final days = int.parse(d.substring(0, d.indexOf(' ')));
      if (days >= 0 && days <= duration) {
        return true;
      }
      return false;
    }

    return ValueListenableBuilder(
        valueListenable: Hive.box('todos').listenable(),
        builder: (context, box, widget) {
          final tasksList = box.values.toList().reversed.toList();

          late List tasks;
          if (startDate.isNotEmpty) {
            switch (range) {
              case "Day":
                tasks = tasksList
                    .where(
                      (element) => dateDifference(element['due'].toString())
                          .contains('hours'),
                    )
                    .toList();
                break;
              case 'Week':
                tasks =
                    tasksList.where((element) => calcDays(element, 7)).toList();
              case 'Month':
                tasks = tasksList
                    .where((element) => calcDays(element, 31))
                    .toList();

              default:
                tasks = tasksList;
            }
          } else {
            tasks = tasksList;
          }

          if (tasks.isEmpty) {
            return const Center(
              child: Text('You have not created any project'),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            controller: controller,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final tags = task['tags'].toString().split(',');
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      task['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        openBottomSheet(
                            context,
                            [
                              Button(
                                onPressed: () {
                                  box.deleteAt(index).then((value) {
                                    pop(context);
                                    showSnackBar(
                                      context,
                                      "Successful deleted",
                                    );
                                  }).catchError((err) {
                                    print(err);
                                    showSnackBar(
                                        context, "Sorry an error occurred");
                                  });
                                },
                                text: 'Delete',
                              )
                            ],
                            maxHeight: .15,
                            initHeight: .14);
                      },
                    ),
                    subtitle: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: SizedBox(
                            width: width(context),
                            child: Text(task['description']),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Due in: ${dateDifference(task['due'])}',
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: width(context),
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tags.length,
                              itemBuilder: (_, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Chip(
                                    label: Text(
                                      tags[i],
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: showSuggestions ? 20 : 0),
                          child: SizedBox(
                            width: width(context),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  showSuggestions = !showSuggestions;
                                });
                              },
                              child: Text(
                                !showSuggestions
                                    ? "Show suggestions"
                                    : "Hide Suggestion",
                              ),
                            ),
                          ),
                        ),
                        if (showSuggestions)
                          for (int i = 0; i < suggestions.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: suggestions[i].contains('\n')
                                  ? SizedBox(
                                      width: width(context),
                                      child: Wrap(
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
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                                bottom: 10,
                                              ),
                                              child: Text(suggestion),
                                            )
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: width(context),
                                      child: Text(
                                        "${i + 1}. ${suggestions[i]}",
                                      ),
                                    ),
                            )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
