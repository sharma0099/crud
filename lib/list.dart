import 'package:crud/add_dialog.dart';
import 'package:crud/database_provider.dart';
import 'package:crud/todo_modal.dart';
import 'package:crud/update_dialog.dart';
import 'package:flutter/material.dart';

class ListViewCrud extends StatefulWidget {
  const ListViewCrud({super.key});

  @override
  State<ListViewCrud> createState() => _ListViewCrudState();
}

class _ListViewCrudState extends State<ListViewCrud> {
  var list = <String>["Black", "Red", "Green"];
  DatabaseProvider databaseProvider = DatabaseProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 16, 163, 221),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 77, 23, 87)),
        title: const Text('List of CRUD'),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(child: Text(list[index])),
                GestureDetector(
                  child: Icon(Icons.edit),
                  onTap: () {
                    showDialog(
                            context: context,
                            builder: (context) => UpdateDialog(list[index]))
                        .then((value) {
                      list[index] = value;
                      setState(() {});
                    });
                  },
                ),
                GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: () {
                    list.removeAt(index);
                    setState(() {});
                  },
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddDialog())
              .then((value) {
            TodoModal todoModal =
                TodoModal(title: value, description: "THIS IS TESTING");
            databaseProvider.insertTodo(todoModal);
            list.add(value);
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
