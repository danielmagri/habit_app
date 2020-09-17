import 'package:altitude/common/model/Competition.dart';
import 'package:altitude/common/model/Competitor.dart';
import 'package:altitude/common/model/Habit.dart';
import 'package:altitude/common/controllers/HabitsControl.dart';
import 'package:altitude/core/services/Database.dart';
import 'package:altitude/core/services/FireAnalytics.dart';
import 'package:altitude/core/services/FireFunctions.dart';
import 'package:altitude/core/services/FireMenssaging.dart';
import 'package:altitude/core/extensions/DateTimeExtension.dart';
import 'package:altitude/common/useCase/PersonUseCase.dart';

@deprecated
class CompetitionsControl {

  final PersonUseCase personUseCase = PersonUseCase.getInstance;


  Future<int> get competitionsCount => DatabaseService().getCompetitionsCount();

  Future<Competition> createCompetition(
      String title, int habitId, List<String> invitations, List<String> invitationsToken) async {
    try {
      Habit habit = await HabitsControl().getHabit(habitId);
      DateTime date = DateTime.now().today;

      Competitor competitor = Competitor(
          name: personUseCase.name,
          fcmToken: await FireMessaging().getToken(),
          color: habit.colorCode,
          score: await HabitsControl().getHabitScore(habitId, date));

      String id = await FireFunctions()
          .createCompetition(title, date.millisecondsSinceEpoch, competitor, invitations, invitationsToken);

      FireAnalytics().sendCreateCompetition(title, habit.habit, invitations.length);
      await DatabaseService().createCompetitition(id, title, habitId, date);
      return Competition(id: id, title: title, initialDate: date, competitors: [competitor]);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> updateCompetition(String id, String title) async {
    var result = await FireFunctions().updateCompetition(id, title);
    if (result) {
      return await DatabaseService().updateCompetition(id, title);
    } else {
      return false;
    }
  }

  Future<bool> addCompetitor(String id, String name, List<String> invitations, List<String> invitationsToken) async {
    return await FireFunctions().addCompetitor(id, name, invitations, invitationsToken);
  }

  Future<bool> removeCompetitor(String id, String uidCompetitor) async {
    var result = await FireFunctions().removeCompetitor(id, uidCompetitor);

    if (result && uidCompetitor == personUseCase.uid) {
      return await DatabaseService().removeCompetition(id);
    } else {
      return result;
    }
  }

  Future<List<Competition>> getPendingCompetitions() async {
    return await FireFunctions().getPendingCompetitions();
  }

  Future<void> acceptCompetitionRequest(String id, String title, DateTime date, int habitId) async {
    try {
      Habit habit = await HabitsControl().getHabit(habitId);

      await FireFunctions().acceptCompetitionRequest(id, personUseCase.name,
          await FireMessaging().getToken(), habit.colorCode, await HabitsControl().getHabitScore(habitId, date));

      return await DatabaseService().createCompetitition(id, title, habitId, date);
    } catch (e) {
      throw e;
    }
  }

  Future<void> declineCompetitionRequest(String id) async {
    return await FireFunctions().declineCompetitionRequest(id);
  }
}
