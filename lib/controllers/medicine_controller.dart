import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/medicine_model.dart';
import '../services/notification_service.dart';

class MedicineController extends GetxController {
  late Box<Medicine> _box;

  var medicines = <Medicine>[].obs;

  @override
  void onInit() {
    super.onInit();
    _box = Hive.box<Medicine>('medicines');
    loadMedicines();
  }

  void loadMedicines() {
    medicines.value = _box.values.toList();
    sortMedicines();
  }

  void sortMedicines() {
    medicines.sort((a, b) {
      final aMinutes = a.hour * 60 + a.minute;
      final bMinutes = b.hour * 60 + b.minute;
      return aMinutes.compareTo(bMinutes);
    });
  }

  Future<void> addMedicine(Medicine medicine) async {
    await _box.add(medicine);

    medicines.add(medicine);
    sortMedicines();

    final now = DateTime.now();
    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      medicine.hour,
      medicine.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    await NotificationService.scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: "Medicine Reminder",
      body: "${medicine.name} - ${medicine.dose}",
      scheduledTime: scheduled,
    );
  }

  void deleteMedicine(int index) async {
    await _box.deleteAt(index);
    medicines.removeAt(index);
  }
}
