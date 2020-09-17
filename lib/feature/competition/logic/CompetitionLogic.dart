import 'package:altitude/common/controllers/CompetitionsControl.dart';
import 'package:altitude/common/model/Competition.dart';
import 'package:altitude/common/model/Habit.dart';
import 'package:altitude/common/model/Person.dart';
import 'package:altitude/common/useCase/CompetitionUseCase.dart';
import 'package:altitude/common/useCase/HabitUseCase.dart';
import 'package:altitude/core/model/DataState.dart';
import 'package:altitude/core/model/Pair.dart';
import 'package:altitude/common/useCase/PersonUseCase.dart';
import 'package:mobx/mobx.dart';
part 'CompetitionLogic.g.dart';

class CompetitionLogic = _CompetitionLogicBase with _$CompetitionLogic;

abstract class _CompetitionLogicBase with Store {
  final PersonUseCase _personUseCase = PersonUseCase.getInstance;
  final HabitUseCase _habitUseCase = HabitUseCase.getInstance;
  final CompetitionUseCase _competitionUseCase = CompetitionUseCase.getInstance;

  @observable
  bool pendingStatus = false;

  DataState<List<Person>> ranking = DataState();
  DataState<ObservableList<Competition>> competitions = DataState();

  bool get isLogged => _personUseCase.isLogged;

  Future<void> fetchData() async {
    checkPendingFriendsStatus();

    fetchCompetitions();

    (await _personUseCase.rankingFriends()).result((value) async {
      Person me = (await _personUseCase.getPerson()).absoluteResult();
      me.you = true;
      value.add(me);
      value.sort((a, b) => -a.score.compareTo(b.score));
      if (value.length > 3) {
        value.removeAt(3);
      }
      ranking.setData(value);
    }, (error) {
      ranking.setError(error);
    });
  }

  void fetchCompetitions() async {
    (await _competitionUseCase.getCompetitions()).result((data) {
      competitions.setData(data.asObservable());
    }, (error) {
      competitions.setError(error);
    });
  }

  @action
  void checkPendingFriendsStatus() {
    pendingStatus = _competitionUseCase.pendingCompetitionsStatus;
  }

  Future<bool> checkCreateCompetition() => _competitionUseCase.maximumNumberReached();

  Future<Pair<List<Habit>, List<Person>>> getCreationData() async {
    List habits = (await _habitUseCase.getHabits()).absoluteResult();
    List friends = (await _personUseCase.getFriends()).absoluteResult();

    return Pair(habits, friends);
  }

  @action
  Future<bool> exitCompetition(String id) async {
    var res = await CompetitionsControl().removeCompetitor(id, _personUseCase.uid);
    if (res) competitions.data.removeWhere((element) => element.id == id);

    return res;
  }
}
