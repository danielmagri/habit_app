import 'package:altitude/common/model/Person.dart';
import 'package:altitude/common/useCase/CompetitionUseCase.dart';
import 'package:altitude/common/useCase/HabitUseCase.dart';
import 'package:altitude/common/useCase/PersonUseCase.dart';
import 'package:altitude/core/enums/StateType.dart';
import 'package:altitude/core/model/Result.dart';
import 'package:altitude/feature/home/logic/HomeLogic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import '../../config/init_config.dart';

HomeLogic get logic => GetIt.I.get<HomeLogic>();

void main() {
  setUp(() {
    initConfig(mockUseCase: true);
  });

  group('getUser', () {
    //TODO});
  });

  group('getHabits', () {
    //TODO
    // test('returns habits list', () async {
    //   final logic = HomeLogic();

    //   expect(logic.habits.state, StateType.INITIAL);

    //   logic.getHabits();
    // });
  });

  group('fetchPendingStatus', () {
    test('returns true to pending friend status', () async {
      final personUseCase = PersonUseCase.getI;
      final competitionUseCase = CompetitionUseCase.getI;

      expect(logic.pendingFriendStatus, false);

      when(personUseCase.pendingFriendsStatus).thenReturn(true);
      when(competitionUseCase.pendingCompetitionsStatus).thenReturn(false);

      logic.fetchPendingStatus();

      expect(logic.pendingFriendStatus, true);
      expect(logic.pendingCompetitionStatus, false);
    });

    test('returns true to pending competition status', () async {
      final personUseCase = PersonUseCase.getI;
      final competitionUseCase = CompetitionUseCase.getI;

      expect(logic.pendingCompetitionStatus, false);

      when(competitionUseCase.pendingCompetitionsStatus).thenReturn(true);
      when(personUseCase.pendingFriendsStatus).thenReturn(false);

      logic.fetchPendingStatus();

      expect(logic.pendingCompetitionStatus, true);
      expect(logic.pendingFriendStatus, false);
    });
  });

  group('swipeSkyWidget', () {
    test('returns true to sky visibility', () async {
      expect(logic.visibilty, false);

      logic.swipeSkyWidget(true);

      expect(logic.visibilty, true);
    });

    test('returns false to sky visibility', () async {
      logic.swipeSkyWidget(false);

      expect(logic.visibilty, false);
    });
  });

  group('completeHabit', () {
    //TODO
  });

  group('checkLevelUp', () {
    test('returns has level up', () async {
      final personUseCase = PersonUseCase.getI;

      when(personUseCase.getScore()).thenAnswer((_) async => 0);

      bool res = await logic.checkLevelUp(20);

      expect(res, true);
    });

    test('returns hasn\'t level up', () async {
      final personUseCase = PersonUseCase.getI;

      when(personUseCase.getScore()).thenAnswer((_) async => 19);

      bool res = await logic.checkLevelUp(20);

      expect(res, false);
    });
  });

  group('canAddHabit', () {
    test('returns true to add a habit', () async {
      final habitUseCase = HabitUseCase.getI;

      when(habitUseCase.maximumNumberReached()).thenAnswer((_) async => true);

      expect(await logic.canAddHabit(), true);
    });

    test('returns false to add a habit', () async {
      final habitUseCase = HabitUseCase.getI;

      when(habitUseCase.maximumNumberReached()).thenAnswer((_) async => false);

      expect(await logic.canAddHabit(), false);
    });
  });
}
