import 'package:hive/hive.dart';

class Medicine {
  String name;
  String dose;
  int hour;
  int minute;

  Medicine({
    required this.name,
    required this.dose,
    required this.hour,
    required this.minute,
  });
}

class MedicineAdapter extends TypeAdapter<Medicine> {
  @override
  final int typeId = 0;

  @override
  Medicine read(BinaryReader reader) {
    return Medicine(
      name: reader.readString(),
      dose: reader.readString(),
      hour: reader.readInt(),
      minute: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.dose);
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}
