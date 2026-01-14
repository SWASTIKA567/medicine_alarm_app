import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/medicine_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Medicine>('medicines');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Reminder"),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Medicine> box, _) {
          final medicines = box.values.toList();

          medicines.sort((a, b) {
            final aMinutes = a.hour * 60 + a.minute;
            final bMinutes = b.hour * 60 + b.minute;
            return aMinutes.compareTo(bMinutes);
          });

          if (medicines.isEmpty) {
            return const Center(
              child: Text(
                "No medicines scheduled yet",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final med = medicines[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.medication,
                    color: Colors.teal,
                    size: 30,
                  ),
                  title: Text(
                    med.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text("Dose: ${med.dose}"),
                      const SizedBox(height: 4),
                      Text(
                        "Time: ${TimeOfDay(hour: med.hour, minute: med.minute).format(context)}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
