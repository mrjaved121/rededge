// Utility functions like validators, formatters, etc.
String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}

bool isValidEmail(String email) {
  return email.contains('@');
}
