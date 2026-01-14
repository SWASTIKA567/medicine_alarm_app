import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/medicine_controller.dart';
import '../models/medicine_model.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();

  TimeOfDay? selectedTime;

  final MedicineController controller = Get.find<MedicineController>();

  void pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void saveMedicine() {
    if (_nameController.text.trim().isEmpty ||
        _doseController.text.trim().isEmpty ||
        selectedTime == null) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final medicine = Medicine(
      name: _nameController.text.trim(),
      dose: _doseController.text.trim(),
      hour: selectedTime!.hour,
      minute: selectedTime!.minute,
    );

    controller.addMedicine(medicine);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Medicine"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Medicine Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _doseController,
              decoration: const InputDecoration(
                labelText: "Dose",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: pickTime,
                child: Text(
                  selectedTime == null
                      ? "Pick Time"
                      : "Time: ${selectedTime!.format(context)}",
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: saveMedicine,
                child: const Text("Save Medicine"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
