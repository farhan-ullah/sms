class SchoolSettings {
  String schoolName;
  String schoolAddress;
  String schoolContact;
  String schoolLogoUrl;
  String academicYear;
  String timezone;
  String dateFormat;
  String currency;
  bool isDarkMode;
  bool notificationsEnabled;

  SchoolSettings({
  required this.schoolName,
  required this.schoolAddress,
  required this.schoolContact,
  required this.schoolLogoUrl,
  required this.academicYear,
  required this.timezone,
  required this.dateFormat,
  required this.currency,
  required this.isDarkMode,
  required this.notificationsEnabled,
  });
}
