import 'package:flutter/material.dart';
import 'package:todo_list/todo_list.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key, this.task}) : super(key: key);
  final Task? task;

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}
class _CreateTaskPageState extends State<CreateTaskPage> {
  var title = TextEditingController();
  var description = TextEditingController();
  DateTime? dueDate;
  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
bool isEditMode = false;
  @override
  void initState() {
    super.initState();
    if(widget.task!=null){
      isEditMode=true;
      title.text=widget.task!.title;
      description.text=widget.task!.description;
      dueDate=widget.task!.dueDate;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ?'Update List':'Create List'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Title', border: OutlineInputBorder()),
                controller: title,
                validator: (String? value) {
                  if (value!.isEmpty)
                    return "This field is required";
                  else
                    return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
                controller: description,
                validator: (String? value) {
                  if (value!.isEmpty)
                    return "This field is required";
                  else
                    return null;
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000));
                  print(selectedDate);
                  if (selectedDate != null) {
                    dueDate = selectedDate;
                    setState(() {});
                  }
                },
                child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all()),
                    child: Center(child: Text( (dueDate==null) ?'Select due date ':dueDate!.toIso8601String()))),
              ),
              SizedBox(height: 1
                  0),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (dueDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('You must select due date')));
                      } else {
                        Navigator.pop(
                            context,
                            Task(
                                title: title.text,
                                description: description.text,
                                dueDate: dueDate!));
                      }
                    } else {
                      setState(() {});
                      autoValidateMode = AutovalidateMode.always;
                    }
                  },
                  child: Text(isEditMode ? 'Update':'Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
