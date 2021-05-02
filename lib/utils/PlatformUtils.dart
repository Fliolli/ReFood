import 'dart:io' show Platform;

T selectByPlatform<T>(T iosValue, T androidValue) {
  return Platform.isIOS == true ? iosValue : androidValue;
}

String formatTimeDifference(DateTime moment) {
  Duration timeDifference = findTimeDifference(moment);

  if (timeDifference.inSeconds < 60)
    return 'Добавлено только что';
  else if (timeDifference.inMinutes < 60)
    return 'Добавлено ${timeDifference.inMinutes.toString()} минут(ы) назад';
  else if (timeDifference.inHours < 24)
    return 'Добавлено ${timeDifference.inHours.toString()} часов(а) назад';
  else if (timeDifference.inDays < 365)
    return 'Добавлено ${timeDifference.inDays.toString()} дней(я) назад';
  else
    return 'Добавлено более года назад';
}

Duration findTimeDifference(DateTime moment) {
  return DateTime.now().difference(moment);
}
