import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  convertFrontEnd() {
    DateTime _time = this;
    List<String> _months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String _formattedYearDay = DateFormat('dd,yyyy').format(_time);
    String _formattedDate =
        "${_months[_time.month].substring(0, 3)} " + _formattedYearDay;
    return _formattedDate;
  }

  toBackEnd() {
    DateTime _time = this;
    String _formattedDate = DateFormat("yyyy-MM-dd").format(_time);
    print(_formattedDate);

    return _formattedDate;
  }
}
