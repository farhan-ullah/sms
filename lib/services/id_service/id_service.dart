import 'package:hive/hive.dart';

import '../../constants/common_keys.dart';

class IDService {
  static late Box _idBox;

  // Initialize Hive box for storing IDs (only once)
  static Future<void> initialize() async {
    _idBox = await Hive.openBox(CommonKeys.UNIQQUE_ID_BOX_KEY);
  }

  static Future<String> getLatestID(String type) async {
    if (!_idBox.isOpen) {
      throw StateError("Hive box is not initialized.");
    }

    // Define prefixes for each type
    final Map<String, String> prefixes = {
      CommonKeys.STUDENT_ID_KEY: 'STN-0',
      CommonKeys.TEACHER_ID_KEY: 'THR-0',
      CommonKeys.CLASS_ID_KEY: 'CLS-0',
      CommonKeys.FEE_ID_KEY: 'FEE-0',
      CommonKeys.PARENT_ID_KEY: 'PTN-0',
      CommonKeys.SUBJECT_ID_KEY: 'SUB-0',

      "": "GRL-0"
    };

    // Check if the type is valid
    if (!prefixes.containsKey(type)) {
      throw ArgumentError('Invalid type specified');
    }

    // Get the list of existing IDs from the box
    List<String> existingIds = List<String>.from(_idBox.get(type, defaultValue: []));

    // Get the current counter for the given type, defaulting to 0
    int counter = _idBox.get('${type}Counter', defaultValue: 1);

    // Generate the last ID with leading zeros (3 digits for the counter) and a dash before the number
    String latestId = '${prefixes[type]}${counter.toString().padLeft(3, '0')}';  // 3 digits for counter

    // Check if the generated ID exists in the list of existing IDs
    if (existingIds.isEmpty || !existingIds.contains(latestId)) {
      // If no ID exists, return the latest possible ID for the type (based on counter)
      return latestId;
    }

    return latestId;
  }



  // Generate unique ID based on type with a specific format
  static Future<String> generateUniqueID(String type) async {
    if (!_idBox.isOpen) {
      throw StateError("Hive box is not initialized.");
    }

    // Define prefixes for each type
    final Map<String, String> prefixes = {
      CommonKeys.STUDENT_ID_KEY: 'STN-0',
      CommonKeys.TEACHER_ID_KEY: 'THR-0',
      CommonKeys.CLASS_ID_KEY: 'CLS-0',
      CommonKeys.FEE_ID_KEY: 'FEE-0',
      CommonKeys.PARENT_ID_KEY: 'PTN-0',
      CommonKeys.SUBJECT_ID_KEY: 'SUB-0',

      "":"GRL-0"
    };

    // Check if the type is valid
    if (!prefixes.containsKey(type)) {
      throw ArgumentError('Invalid type specified');
    }

    // Get the list of existing IDs from the box
    List<String> existingIds = List<String>.from(_idBox.get(type, defaultValue: []));

    // Get the current counter for the given type, defaulting to 0
    int counter = _idBox.get('${type}Counter', defaultValue: 1);

    // Increment the counter for this type
    counter++;

    // Generate the new ID with leading zeros (3 digits for the counter) and a dash before the number
    String newId = '${prefixes[type]}${counter.toString().padLeft(3, '0')}';  // 3 digits for counter

    // Ensure no duplicates by checking the list of existing IDs
    while (existingIds.contains(newId)) {
      counter++;
      newId = '${prefixes[type]}${counter.toString().padLeft(3, '0')}';
    }

    // Add the new ID to the list of existing IDs for this type
    existingIds.add(newId);

    // Save the updated list of IDs and counter back into the Hive box
    await _idBox.put(type, existingIds);
    await _idBox.put('${type}Counter', counter); // Store the updated counter

    return newId;
  }

  // Function to manually set or update the counter for a specific type
  static Future<void> setCounterForType(String type, int newCounterValue) async {
    if (!_idBox.isOpen) {
      throw StateError("Hive box is not initialized.");
    }

    if (!['student', 'teacher', 'class', 'fee', 'parent'].contains(type)) {
      throw ArgumentError('Invalid type specified');
    }

    // Update the counter for the specific type
    await _idBox.put('${type}Counter', newCounterValue);
  }
}
