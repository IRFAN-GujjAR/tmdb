final class DateUtl {
  static String? formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return null;
    }

    String day = date.substring(8, 10);
    String month = date.substring(5, 7);
    if (month.startsWith('0')) {
      month = month.substring(1);
    }
    String year = date.substring(0, 4);
    String monthInLetters = _formatMonth(month);

    String formattedDate = day + ' ' + monthInLetters + ' ' + year;

    return formattedDate;
  }

  static String _formatMonth(String month) {
    String monthInLetters = '';

    switch (month) {
      case '1':
        monthInLetters = 'January';
        break;
      case '2':
        monthInLetters = 'February';
        break;
      case '3':
        monthInLetters = 'March';
        break;
      case '4':
        monthInLetters = 'April';
        break;
      case '5':
        monthInLetters = 'May';
        break;
      case '6':
        monthInLetters = 'June';
        break;
      case '7':
        monthInLetters = 'July';
        break;
      case '8':
        monthInLetters = 'August';
        break;
      case '9':
        monthInLetters = 'September';
        break;
      case '10':
        monthInLetters = 'October';
        break;
      case '11':
        monthInLetters = 'November';
        break;
      case '12':
        monthInLetters = 'December';
        break;
    }

    return monthInLetters;
  }
}
