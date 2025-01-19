class Timetable {
  // Singleton instance
  static final Timetable _instance = Timetable._internal();

  // Access the singleton instance
  factory Timetable() {
    return _instance;
  }

  // Private constructor for singleton
  Timetable._internal();

  // Days of the week
  final List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  // Time slots for each day
  final List<String> timeSlots = [
    "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM"
  ];

  // A map to store subjects for each day
  Map<String, List<String>> timetableData = {};

  // Populate with dummy data
  void initialize() {
    timetableData = {
      'Monday': ['Math', 'English', 'Science', 'History', 'PE', 'Art', 'Music', 'Geography'],
      'Tuesday': ['History', 'Math', 'Biology', 'Chemistry', 'Art', 'PE', 'Physics', 'Literature'],
      'Wednesday': ['Chemistry', 'PE', 'Math', 'History', 'Physics', 'Biology', 'English', 'Art'],
      'Thursday': ['Physics', 'Biology', 'English', 'Math', 'Art', 'Chemistry', 'Music', 'History'],
      'Friday': ['Music', 'History', 'PE', 'Math', 'English', 'Biology', 'Chemistry', 'Geography'],
    };
  }
}
