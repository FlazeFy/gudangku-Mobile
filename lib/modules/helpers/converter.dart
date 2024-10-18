import 'package:intl/intl.dart';

String getMessageResponseFromObject(val, type) {
  var res = "";

  if (val is String) {
    return val;
  } else {
    if (type == "login") {
      if (val.containsKey('username') != null) {
        var usernameErr = val['username'];

        if (usernameErr != null) {
          res += "${usernameErr.join('\n')}";
        }
      }
      if (val.containsKey('password')) {
        var passErr = val['password'];
        if (passErr != null) {
          res += "${passErr.join('\n')}";
        }
      }
    }

    return res;
  }
}

String ucFirst(String val) {
  String res = "";
  if (val.trim() != "") {
    res = val[0].toUpperCase() + val.substring(1);
  }
  return res;
}

String ucAll(String val) {
  List<String> words = val.split(' ');
  words =
      words.map((word) => word[0].toUpperCase() + word.substring(1)).toList();
  return words.join(' ');
}

String getLocalConvertedDate(String date) {
  DateTime now = DateTime.now();
  Duration timeZoneOffset = now.timeZoneOffset;
  DateTime localDateTime = DateTime.parse(date).add(timeZoneOffset);

  return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
}

getItemTimeString(date) {
  if (date != null) {
    //Initial variable.
    final now = DateTime.now();

    //Check this again!
    if (date is DateTime) {
      date = DateTime.parse(getLocalConvertedDate(
          DateFormat('yyyy-MM-dd HH:mm:ss').format(date)));
    } else {
      date = DateTime.parse(getLocalConvertedDate(
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(date))));
    }

    final today = DateTime(now.year, now.month, now.day);
    final justNowHour = DateTime(now.hour);
    final justNowMinute = DateFormat("mm").format(now);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final content = DateTime(date.year, date.month, date.day);
    final contentHour = DateTime(date.hour);
    final contentMinute = DateFormat("mm").format(date);

    var result = "";

    if (content == today) {
      if (justNowHour == contentHour) {
        int diff = int.parse((justNowMinute).toString()) -
            int.parse((contentMinute).toString());
        if (diff > 10) {
          result = "$diff min ago";
        } else {
          result = "Just Now";
        }
      } else {
        result = "Today at ${DateFormat("HH:mm").format(date).toString()}";
      }
    } else if (content == yesterday) {
      result = "Yesterday at ${DateFormat("HH:mm").format(date).toString()}";
    } else {
      result = DateFormat("yyyy/MM/dd HH:mm").format(date).toString();
    }

    return result;
  } else {
    return "-";
  }
}
