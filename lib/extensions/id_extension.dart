import 'package:hive/hive.dart';

extension IDGenerator on Box {
  Future<String> generateUniqueID(String type) async {
    // Define prefixes for each type
    final Map<String, String> prefixes = {
      'student': 'STN-',
      'teacher': 'THR-',
      'class': 'CLS-',
      'fee': 'FEE-',
      'parent': 'PTN-',
    };

    // Check if the type is valid
    if (!prefixes.containsKey(type)) {
      throw ArgumentError('Invalid type specified');
    }

    // Get the list of existing IDs from the box
    List<String> existingIds = List<String>.from(get(type, defaultValue: []));

    // Get the current counter for the given type, defaulting to 0
    int counter = get('${type}Counter', defaultValue: 0);

    // Increment the counter for this type
    counter++;

    // Generate the new ID with leading zeros and a dash before the number
    String newId = '${prefixes[type]}${counter.toString().padLeft(4, '0')}';  // 4 digits for counter

    // Ensure no duplicates by checking the list of existing IDs
    while (existingIds.contains(newId)) {
      counter++;
      newId = '${prefixes[type]}${counter.toString().padLeft(4, '0')}';
    }

    // Add the new ID to the list of existing IDs for this type
    existingIds.add(newId);

    // Save the updated list of IDs and counter back into the Hive box
    await put(type, existingIds);
    await put('${type}Counter', counter); // Store the updated counter

    return newId;
  }
}
