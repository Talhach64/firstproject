import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/create_task_page.dart';

class Task {
  String title;
  String description;
  DateTime dueDate;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
  });
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

int? tasksLength;
List<Task> tasks = [
  Task(
      title: 'Do homework',
      description: "yes I am here to do work",
      dueDate: DateTime.now()),
  Task(
      title: 'Nicely done ',
      description: "Work has been done",
      dueDate: DateTime.now()),
];

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? response = await Navigator.push((context),
              MaterialPageRoute(builder: (context) => CreateTaskPage()));
          if (response != null) {
            tasks.add(response);
            setState(() {});
            tasksLength = 1;
          }
          print('user is back from create page');
        },
        child: Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        title: Text('List'),
      ),
      body: (tasksLength == 0)
          ? Center(
              child: Text(
              'Add new List item',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                Task _task = tasks[i];
                return ListTile(
                    onTap: () async {
                      Task updatedTask = await Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreateTaskPage(task: _task)));
                      tasks[i] = updatedTask;
                      setState(() {});
                    },
                    leading: Text(
                      (i + 1).toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    title: Text(_task.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_task.description),
                        Text(_task.dueDate.toIso8601String()),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        tasks.removeAt(i);
                        setState(() {});
                        print(tasks.length);
                        tasksLength = tasks.length;
                      },
                    ));
              }),
    );
  }
}
