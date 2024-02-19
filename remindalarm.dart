import 'dart:async';
import 'dart:io';

void main() {
  print('Welcome to Alarm Reminder App!');
  print('To set an alarm, enter the time in HH:MM format (24-hour clock).');

  while (true) {
    stdout.write('Enter alarm time (HH:MM) or type "exit" to quit: ');
    var input = stdin.readLineSync();

    if (input?.toLowerCase() == 'exit') {
      print('Exiting...');
      break;
    }

    try {
      var timeParts = input!.split(':');
      if (timeParts.length != 2) {
        throw FormatException('Invalid time format.');
      }

      var hour = int.parse(timeParts[0]);
      var minute = int.parse(timeParts[1]);

      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
        throw FormatException('Invalid time format.');
      }

      var now = DateTime.now();
      var alarmTime = DateTime(now.year, now.month, now.day, hour, minute);

      var timeDifference = alarmTime.difference(now);
      if (timeDifference.isNegative) {
        alarmTime = alarmTime.add(Duration(days: 1));
        timeDifference = alarmTime.difference(now);
      }

      print('Alarm set for $hour:$minute');

      Timer(timeDifference, () {
        print('\n\nALARM! ALARM! ALARM!\n\n');
        print('Alarm Time: $hour:$minute');
        print('Message: Wake up!');
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
