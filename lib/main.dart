import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter/material.dart';
import 'data/entities/entities_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.initDb();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    db.categoryEntitys.get(1);

    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
