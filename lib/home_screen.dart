import 'package:flutter/material.dart';

class Medicine {
  final String name;
  final String dose;
  final TimeOfDay time;

  Medicine({required this.name, required this.dose, required this.time});
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Medicine> medicines = [
    Medicine(
      name: "Paracetamol",
      dose: "1 Tablet",
      time: const TimeOfDay(hour: 14, minute: 0),
    ),
    Medicine(
      name: "Vitamin C",
      dose: "2 Tablets",
      time: const TimeOfDay(hour: 9, minute: 0),
    ),
    Medicine(
      name: "Insulin",
      dose: "10 ml",
      time: const TimeOfDay(hour: 20, minute: 30),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    medicines.sort((a, b) {
      final aMinutes = a.time.hour * 60 + a.time.minute;
      final bMinutes = b.time.hour * 60 + b.time.minute;
      return aMinutes.compareTo(bMinutes);
    });

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
      body: medicines.isEmpty
          ? const Center(
              child: Text(
                "No medicines scheduled yet",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
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
                          "Time: ${med.time.format(context)}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
