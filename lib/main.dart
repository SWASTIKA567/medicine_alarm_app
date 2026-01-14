import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/medicine_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MedicineAdapter());
  await Hive.openBox<Medicine>('medicines');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicine Reminder',
      theme: ThemeData(primaryColor: Colors.teal),
      home: HomeScreen(),
    );
  }
}
