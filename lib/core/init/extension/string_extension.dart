extension StringExtension on String {
  convertDateTime() {
    try {
      String data = this;
      List parts = data.split("-");
      String year = parts[0];
      String month = parts[1];
      String day = parts[2];
      return DateTime(int.parse(year), int.parse(month), int.parse(day));
    } catch (ex) {
      return DateTime(0, 0, 0);
    }
  }
}
