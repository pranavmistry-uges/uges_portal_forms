import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  /// Saves the form JSON data to local storage under the specified [formName] key.
  static Future<void> saveFormData(String formName, String jsonData) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve any existing data for this form, or start a new list
    List<String> existingData = prefs.getStringList(formName) ?? [];

    // Add the new submission
    existingData.add(jsonData);

    // Save the updated list back to SharedPreferences
    await prefs.setStringList(formName, existingData);
  }
}
