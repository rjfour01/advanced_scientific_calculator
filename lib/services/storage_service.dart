import 'package:hive/hive.dart';
import '../models/calculation.dart';

class StorageService {
  static const String boxName = 'calculation_history';

  Future<void> addCalculation(Calculation calc) async {
    var box = await Hive.openBox(boxName);
    await box.add(calc.toMap());
  }

  Future<List<Calculation>> getCalculations() async {
    var box = await Hive.openBox(boxName);
    return box.values
        .map((e) => Calculation.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> clearHistory() async {
    var box = await Hive.openBox(boxName);
    await box.clear();
  }
}
