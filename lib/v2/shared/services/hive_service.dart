import 'package:hive_flutter/hive_flutter.dart';
import 'package:ribn/v2/shared/services/hives.dart';

class HiveService {
  final HiveBox hiveBox;

  HiveService(this.hiveBox);

  Future<Box<dynamic>> _openBox(String box) async {
    return await Hive.openBox(box);
  }

  Future<void> putItem({
    required String key,
    required dynamic value,
  }) async {
    final box = await _openBox(hiveBox.id);
    await box.put(key, value);
  }

  Future<dynamic> getItem({
    required String key,
  }) async {
    final box = await _openBox(hiveBox.id);
    return box.get(key);
  }

  Future<Iterable<dynamic>> getAllItems() async {
    final box = await _openBox(hiveBox.id);
    return box.values;
  }

  Future<void> deleteItem({
    required String key,
  }) async {
    final box = await _openBox(hiveBox.id);
    await box.delete(key);
  }

  Future<void> deleteBox() async {
    final box = await _openBox(hiveBox.id);
    await box.deleteFromDisk();
  }

  Future<void> deleteAll() async {
    await Hive.deleteFromDisk();
  }
}
