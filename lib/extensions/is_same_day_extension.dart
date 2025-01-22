// Create a DateTime extension to check if two DateTime objects are on the same day
extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
