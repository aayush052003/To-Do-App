import 'package:flutter/material.dart';
import 'package:practice/helper/border.dart';

import 'model/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController task = TextEditingController();
  TextEditingController editTask = TextEditingController();
  List<Task> taskList = [];
  void addTask() {
    String newTask = task.text.trim();
    if (newTask.isNotEmpty) {
      setState(() {
        taskList.add(Task(title: newTask, isDone: false));
        task.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Filled task detail",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void toggleTask(int index) {
    setState(() {
      taskList[index].isDone = !taskList[index].isDone;
    });
  }

  void onDelete(int index){
    setState(() {
      taskList.removeAt(index);
    });
  }

  void onEdit(int index){
    String editedTask = editTask.text.trim();
    setState(() {
      taskList[index].title = editedTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff3B7582),
        title: Text(
          "To-Do List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
          taskList.isEmpty
              ? Center(
                child: Text(
                  "No task yet!",
                  style: TextStyle(fontSize: 26, color: Color(0xff3B7582)),
                ),
              )
              : SafeArea(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, item) {
                    final t = taskList[item];
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xff3B7582)),
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          activeColor: Color(0xff3B7582),
                          checkColor: Colors.white,
                          value: t.isDone,
                          onChanged: (_) => toggleTask(item),
                        ),
                        title: Text(
                          t.title,
                          style: TextStyle(color: Color(0xff3B7582),fontSize: 18,decoration: t.isDone ? TextDecoration.lineThrough : TextDecoration.none,decorationColor: Color(0xff3B7582)),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){
                              editTask.text = t.title;
                              showDialog(
                                  context: context, builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                backgroundColor: Colors.white,
                                title: Text("Edit task",style: TextStyle(fontSize: 18),),
                                content: TextField(
                                  controller: editTask,
                                  decoration: InputDecoration(
                                    enabledBorder: border,
                                    focusedBorder: border,
                                    errorBorder: border,
                                    focusedErrorBorder: border,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff3B7582),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                      ),
                                      onPressed: (){
                                        onEdit(item);
                                        Navigator.pop(context);
                                      }, child: Text("Save",style: TextStyle(color: Colors.white),),)
                                ],
                              ));
                            }, icon: Icon(Icons.edit,color: Color(0xff3B7582),)),
                            IconButton(
                              onPressed: (){
                                onDelete(item);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        )
                      ),
                    );
                  },
                ),
              ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width * 0.9,
            child: TextField(
              controller: task,
              decoration: InputDecoration(
                hintText: "Add Task...",
                filled: true,
                fillColor: Colors.white,
                enabledBorder: border,
                focusedBorder: border,
                errorBorder: border,
                focusedErrorBorder: border,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xff3B7582),
                    ),
                    onPressed: addTask,
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
