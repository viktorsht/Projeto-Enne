class SetDateHour{
  bool isDateToday(String dateString) {
    // Converter a string de data em um objeto DateTime
    DateTime date = DateTime.parse(dateString);
    bool retorno = false;

    // Obter a data atual
    DateTime now = DateTime.now();

    // Verificar se a data é igual à data atual
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      retorno = true;
    }
    return retorno;
  }

  bool isTimeAfterNow(String timeString) {
    // Obter a hora e os minutos a partir da string
    List<String> parts = timeString.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    bool retorno = false;

    // Obter o horário atual
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    int currentMinute = now.minute;

    // Verificar se a hora é maior ou igual ao horário atual
    if (hour > currentHour) {
      retorno = true;
    } else if (hour == currentHour && minute >= currentMinute) {
      retorno = true;
    }
    return retorno;
  }
}