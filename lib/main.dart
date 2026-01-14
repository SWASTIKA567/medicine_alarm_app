import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/medicine_model.dart';
import 'package:get/get.dart';

import 'services/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MedicineAdapter());
  await Hive.openBox<Medicine>('medicines');

  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicine Reminder',
      theme: ThemeData(primaryColor: Colors.teal),
      home: HomeScreen(),
    );
  }
}
