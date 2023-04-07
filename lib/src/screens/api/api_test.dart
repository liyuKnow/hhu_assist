import 'package:flutter/material.dart';
import 'package:hhu_assist/src/data/remote/base_client.dart';
import 'package:hhu_assist/src/data/remote/model/todo.dart';

class APITest extends StatefulWidget {
  const APITest({super.key});

  @override
  State<APITest> createState() => _APITestState();
}

class _APITestState extends State<APITest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Response Test'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var res = await BaseClient().get('todos').catchError((error) {
          debugPrint(error);
        });

        if (res == null) return;
        for (var r in res) {
          var todos = Todo.fromJson(r);
          // var todos = todoFromJson(r);
        }

        debugPrint("${res}");
        // debugPrint("${todos}");
      }),
    );
  }
}
