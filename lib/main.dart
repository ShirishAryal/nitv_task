import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nitv_task_repository/nitv_task_repository.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('news');
  runApp(NewsApp(nitvTaskRepository: NitvTaskRepository()));
}
