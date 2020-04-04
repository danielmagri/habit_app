import 'package:altitude/common/model/Frequency.dart';
import 'package:altitude/common/model/Habit.dart';
import 'package:altitude/common/model/Reminder.dart';

class EditHabitPageArguments {
  final Habit habit;
  final Frequency frequency;
  final List<Reminder> reminders;

  EditHabitPageArguments(this.habit, this.frequency, this.reminders);
}