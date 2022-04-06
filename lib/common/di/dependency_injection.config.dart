// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/repository/competitions_repository.dart' as _i23;
import '../../data/repository/friends_repository.dart' as _i24;
import '../../data/repository/habits_repository.dart' as _i25;
import '../../data/repository/notifications_repository.dart' as _i17;
import '../../data/repository/user_repository.dart' as _i26;
import '../../domain/usecases/auth/auth_google_usecase.dart' as _i4;
import '../../domain/usecases/auth/logout_usecase.dart' as _i29;
import '../../domain/usecases/competitions/accept_competition_request_usecase.dart'
    as _i45;
import '../../domain/usecases/competitions/create_competition_usecase.dart'
    as _i50;
import '../../domain/usecases/competitions/decline_competition_request_usecase.dart'
    as _i52;
import '../../domain/usecases/competitions/get_competition_usecase.dart'
    as _i59;
import '../../domain/usecases/competitions/get_competitions_usecase.dart'
    as _i60;
import '../../domain/usecases/competitions/get_pending_competitions_usecase.dart'
    as _i65;
import '../../domain/usecases/competitions/has_competition_by_habit_usecase.dart'
    as _i70;
import '../../domain/usecases/competitions/invite_competitor_usecase.dart'
    as _i27;
import '../../domain/usecases/competitions/max_competitions_by_habit_usecase.dart'
    as _i30;
import '../../domain/usecases/competitions/max_competitions_usecase.dart'
    as _i31;
import '../../domain/usecases/competitions/remove_competitor_usecase.dart'
    as _i34;
import '../../domain/usecases/competitions/update_competition_usecase.dart'
    as _i38;
import '../../domain/usecases/friends/accept_request_usecase.dart' as _i46;
import '../../domain/usecases/friends/cancel_friend_request_usecase.dart'
    as _i48;
import '../../domain/usecases/friends/decline_request_usecase.dart' as _i53;
import '../../domain/usecases/friends/friend_request_usecase.dart' as _i56;
import '../../domain/usecases/friends/get_friends_usecase.dart' as _i62;
import '../../domain/usecases/friends/get_pending_friends_usecase.dart' as _i66;
import '../../domain/usecases/friends/get_ranking_friends_usecase.dart' as _i67;
import '../../domain/usecases/friends/remove_friend_usecase.dart' as _i35;
import '../../domain/usecases/friends/search_email_usecase.dart' as _i36;
import '../../domain/usecases/habits/add_habit_usecase.dart' as _i47;
import '../../domain/usecases/habits/complete_habit_usecase.dart' as _i49;
import '../../domain/usecases/habits/delete_habit_usecase.dart' as _i54;
import '../../domain/usecases/habits/get_all_days_done_usecase.dart' as _i57;
import '../../domain/usecases/habits/get_calendar_days_done_usecase.dart'
    as _i58;
import '../../domain/usecases/habits/get_days_done_usecase.dart' as _i61;
import '../../domain/usecases/habits/get_habit_usecase.dart' as _i63;
import '../../domain/usecases/habits/get_habits_usecase.dart' as _i64;
import '../../domain/usecases/habits/get_reminder_counter_usecase.dart' as _i68;
import '../../domain/usecases/habits/max_habits_usecase.dart' as _i32;
import '../../domain/usecases/habits/transfer_habit_usecase.dart' as _i37;
import '../../domain/usecases/habits/update_habit_usecase.dart' as _i40;
import '../../domain/usecases/habits/update_reminder_usecase.dart' as _i43;
import '../../domain/usecases/user/create_person_usecase.dart' as _i51;
import '../../domain/usecases/user/get_user_data_usecase.dart' as _i69;
import '../../domain/usecases/user/is_logged_usecase.dart' as _i28;
import '../../domain/usecases/user/recalculate_score_usecasse.dart' as _i33;
import '../../domain/usecases/user/update_fcm_token_usecase.dart' as _i39;
import '../../domain/usecases/user/update_level_usecase.dart' as _i41;
import '../../domain/usecases/user/update_name_usecase.dart' as _i42;
import '../../domain/usecases/user/update_total_score_usecase.dart' as _i44;
import '../../infra/interface/i_fire_analytics.dart' as _i5;
import '../../infra/interface/i_fire_auth.dart' as _i7;
import '../../infra/interface/i_fire_database.dart' as _i9;
import '../../infra/interface/i_fire_functions.dart' as _i11;
import '../../infra/interface/i_fire_messaging.dart' as _i13;
import '../../infra/interface/i_local_notification.dart' as _i15;
import '../../infra/interface/i_score_service.dart' as _i18;
import '../../infra/services/FireAnalytics.dart' as _i6;
import '../../infra/services/FireAuth.dart' as _i8;
import '../../infra/services/FireDatabase.dart' as _i10;
import '../../infra/services/FireFunctions.dart' as _i12;
import '../../infra/services/FireMenssaging.dart' as _i14;
import '../../infra/services/LocalNotification.dart' as _i16;
import '../../infra/services/Memory.dart' as _i21;
import '../../infra/services/score_service.dart' as _i19;
import '../../infra/services/shared_pref/shared_pref.dart' as _i22;
import '../../presentation/competitions/controllers/competition_controller.dart'
    as _i78;
import '../../presentation/competitions/controllers/competition_details_controller.dart'
    as _i79;
import '../../presentation/competitions/controllers/create_competition_controller.dart'
    as _i80;
import '../../presentation/competitions/controllers/pending_competition_controller.dart'
    as _i72;
import '../../presentation/friends/controllers/add_friend_controller.dart'
    as _i76;
import '../../presentation/friends/controllers/friends_controller.dart' as _i81;
import '../../presentation/friends/controllers/pending_friends_controller.dart'
    as _i73;
import '../../presentation/habits/controllers/add_habit_controller.dart'
    as _i77;
import '../../presentation/habits/controllers/edit_alarm_controller.dart'
    as _i83;
import '../../presentation/habits/controllers/edit_cue_controller.dart' as _i84;
import '../../presentation/habits/controllers/edit_habit_controller.dart'
    as _i55;
import '../../presentation/habits/controllers/habit_details_controller.dart'
    as _i82;
import '../../presentation/home/controllers/home_controller.dart' as _i71;
import '../../presentation/login/controllers/login_controller.dart' as _i20;
import '../../presentation/setting/controllers/settings_controller.dart'
    as _i74;
import '../../presentation/statistics/controllers/statistics_controller.dart'
    as _i75;
import '../app_logic.dart' as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AppLogic>(_i3.AppLogic());
  gh.factory<_i4.AuthGoogleUsecase>(() => _i4.AuthGoogleUsecase());
  gh.factory<_i5.IFireAnalytics>(() => _i6.FireAnalytics());
  gh.factory<_i7.IFireAuth>(() => _i8.FireAuth());
  gh.factory<_i9.IFireDatabase>(() => _i10.FireDatabase());
  gh.factory<_i11.IFireFunctions>(() => _i12.FireFunctions());
  gh.factory<_i13.IFireMessaging>(() => _i14.FireMessaging());
  gh.singletonAsync<_i15.ILocalNotification>(
      () => _i16.LocalNotification.initialize());
  gh.factory<_i17.INotificationsRepository>(
      () => _i17.NotificationsRepository(get<_i11.IFireFunctions>()));
  gh.factory<_i18.IScoreService>(() => _i19.ScoreService());
  gh.lazySingleton<_i20.LoginController>(
      () => _i20.LoginController(get<_i4.AuthGoogleUsecase>()));
  gh.singleton<_i21.Memory>(_i21.Memory());
  await gh.singletonAsync<_i22.SharedPref>(() => _i22.SharedPref.initialize(),
      preResolve: true);
  gh.factory<_i23.ICompetitionsRepository>(() => _i23.CompetitionsRepository(
      get<_i21.Memory>(),
      get<_i9.IFireDatabase>(),
      get<_i7.IFireAuth>(),
      get<_i22.SharedPref>(),
      get<_i5.IFireAnalytics>()));
  gh.factory<_i24.IFriendsRepository>(() => _i24.FriendsRepository(
      get<_i9.IFireDatabase>(), get<_i5.IFireAnalytics>(), get<_i21.Memory>()));
  gh.factoryAsync<_i25.IHabitsRepository>(() async => _i25.HabitsRepository(
      get<_i21.Memory>(),
      get<_i9.IFireDatabase>(),
      get<_i18.IScoreService>(),
      await get.getAsync<_i15.ILocalNotification>(),
      get<_i5.IFireAnalytics>()));
  gh.factory<_i26.IUserRepository>(() => _i26.UserRepository(
      get<_i21.Memory>(),
      get<_i13.IFireMessaging>(),
      get<_i9.IFireDatabase>(),
      get<_i7.IFireAuth>(),
      get<_i18.IScoreService>()));
  gh.factory<_i27.InviteCompetitorUsecase>(() => _i27.InviteCompetitorUsecase(
      get<_i23.ICompetitionsRepository>(),
      get<_i26.IUserRepository>(),
      get<_i17.INotificationsRepository>()));
  gh.factory<_i28.IsLoggedUsecase>(
      () => _i28.IsLoggedUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i29.LogoutUsecase>(
      () => _i29.LogoutUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i30.MaxCompetitionsByHabitUsecase>(() =>
      _i30.MaxCompetitionsByHabitUsecase(
          get<_i23.ICompetitionsRepository>(), get<_i26.IUserRepository>()));
  gh.factory<_i31.MaxCompetitionsUsecase>(
      () => _i31.MaxCompetitionsUsecase(get<_i23.ICompetitionsRepository>()));
  gh.factoryAsync<_i32.MaxHabitsUsecase>(() async =>
      _i32.MaxHabitsUsecase(await get.getAsync<_i25.IHabitsRepository>()));
  gh.factory<_i33.RecalculateScoreUsecase>(
      () => _i33.RecalculateScoreUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i34.RemoveCompetitorUsecase>(
      () => _i34.RemoveCompetitorUsecase(get<_i23.ICompetitionsRepository>()));
  gh.factory<_i35.RemoveFriendUsecase>(
      () => _i35.RemoveFriendUsecase(get<_i24.IFriendsRepository>()));
  gh.factory<_i36.SearchEmailUsecase>(() => _i36.SearchEmailUsecase(
      get<_i24.IFriendsRepository>(), get<_i26.IUserRepository>()));
  gh.factoryAsync<_i37.TransferHabitUsecase>(() async =>
      _i37.TransferHabitUsecase(await get.getAsync<_i25.IHabitsRepository>(),
          get<_i26.IUserRepository>()));
  gh.factory<_i38.UpdateCompetitionUsecase>(
      () => _i38.UpdateCompetitionUsecase(get<_i23.ICompetitionsRepository>()));
  gh.factory<_i39.UpdateFCMTokenUsecase>(
      () => _i39.UpdateFCMTokenUsecase(get<_i26.IUserRepository>()));
  gh.factoryAsync<_i40.UpdateHabitUsecase>(() async => _i40.UpdateHabitUsecase(
      await get.getAsync<_i25.IHabitsRepository>(),
      get<_i23.ICompetitionsRepository>(),
      get<_i26.IUserRepository>()));
  gh.factory<_i41.UpdateLevelUsecase>(
      () => _i41.UpdateLevelUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i42.UpdateNameUsecase>(
      () => _i42.UpdateNameUsecase(get<_i26.IUserRepository>()));
  gh.factoryAsync<_i43.UpdateReminderUsecase>(() async =>
      _i43.UpdateReminderUsecase(await get.getAsync<_i25.IHabitsRepository>(),
          get<_i26.IUserRepository>()));
  gh.factory<_i44.UpdateTotalScoreUsecase>(
      () => _i44.UpdateTotalScoreUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i45.AcceptCompetitionRequestUsecase>(() =>
      _i45.AcceptCompetitionRequestUsecase(get<_i23.ICompetitionsRepository>(),
          get<_i17.INotificationsRepository>(), get<_i26.IUserRepository>()));
  gh.factory<_i46.AcceptRequestUsecase>(() => _i46.AcceptRequestUsecase(
      get<_i24.IFriendsRepository>(),
      get<_i17.INotificationsRepository>(),
      get<_i26.IUserRepository>()));
  gh.factoryAsync<_i47.AddHabitUsecase>(() async => _i47.AddHabitUsecase(
      await get.getAsync<_i25.IHabitsRepository>(),
      get<_i26.IUserRepository>()));
  gh.factory<_i48.CancelFriendRequestUsecase>(
      () => _i48.CancelFriendRequestUsecase(get<_i24.IFriendsRepository>()));
  gh.factoryAsync<_i49.CompleteHabitUsecase>(() async =>
      _i49.CompleteHabitUsecase(
          await get.getAsync<_i25.IHabitsRepository>(),
          get<_i23.ICompetitionsRepository>(),
          get<_i17.INotificationsRepository>(),
          get<_i26.IUserRepository>()));
  gh.factoryAsync<_i50.CreateCompetitionUsecase>(() async =>
      _i50.CreateCompetitionUsecase(
          get<_i23.ICompetitionsRepository>(),
          get<_i17.INotificationsRepository>(),
          get<_i26.IUserRepository>(),
          await get.getAsync<_i25.IHabitsRepository>()));
  gh.factory<_i51.CreatePersonUsecase>(
      () => _i51.CreatePersonUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i52.DeclineCompetitionRequestUsecase>(() =>
      _i52.DeclineCompetitionRequestUsecase(
          get<_i23.ICompetitionsRepository>()));
  gh.factory<_i53.DeclineRequestUsecase>(
      () => _i53.DeclineRequestUsecase(get<_i24.IFriendsRepository>()));
  gh.factoryAsync<_i54.DeleteHabitUsecase>(() async =>
      _i54.DeleteHabitUsecase(await get.getAsync<_i25.IHabitsRepository>()));
  gh.lazySingletonAsync<_i55.EditHabitController>(() async =>
      _i55.EditHabitController(await get.getAsync<_i40.UpdateHabitUsecase>(),
          await get.getAsync<_i54.DeleteHabitUsecase>()));
  gh.factory<_i56.FriendRequestUsecase>(() => _i56.FriendRequestUsecase(
      get<_i24.IFriendsRepository>(),
      get<_i17.INotificationsRepository>(),
      get<_i26.IUserRepository>()));
  gh.factoryAsync<_i57.GetAllDaysDoneUsecase>(() async =>
      _i57.GetAllDaysDoneUsecase(await get.getAsync<_i25.IHabitsRepository>()));
  gh.factoryAsync<_i58.GetCalendarDaysDoneUsecase>(() async =>
      _i58.GetCalendarDaysDoneUsecase(
          await get.getAsync<_i25.IHabitsRepository>()));
  gh.factory<_i59.GetCompetitionUsecase>(
      () => _i59.GetCompetitionUsecase(get<_i23.ICompetitionsRepository>()));
  gh.factory<_i60.GetCompetitionsUsecase>(
      () => _i60.GetCompetitionsUsecase(get<_i23.ICompetitionsRepository>()));
  gh.factoryAsync<_i61.GetDaysDoneUsecase>(() async =>
      _i61.GetDaysDoneUsecase(await get.getAsync<_i25.IHabitsRepository>()));
  gh.factory<_i62.GetFriendsUsecase>(
      () => _i62.GetFriendsUsecase(get<_i24.IFriendsRepository>()));
  gh.factoryAsync<_i63.GetHabitUsecase>(() async =>
      _i63.GetHabitUsecase(await get.getAsync<_i25.IHabitsRepository>()));
  gh.factoryAsync<_i64.GetHabitsUsecase>(() async =>
      _i64.GetHabitsUsecase(await get.getAsync<_i25.IHabitsRepository>()));
  gh.factory<_i65.GetPendingCompetitionsUsecase>(() =>
      _i65.GetPendingCompetitionsUsecase(get<_i23.ICompetitionsRepository>()));
  gh.factory<_i66.GetPendingFriendsUsecase>(
      () => _i66.GetPendingFriendsUsecase(get<_i24.IFriendsRepository>()));
  gh.factory<_i67.GetRankingFriendsUsecase>(
      () => _i67.GetRankingFriendsUsecase(get<_i24.IFriendsRepository>()));
  gh.factory<_i68.GetReminderCounterUsecase>(
      () => _i68.GetReminderCounterUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i69.GetUserDataUsecase>(
      () => _i69.GetUserDataUsecase(get<_i26.IUserRepository>()));
  gh.factory<_i70.HasCompetitionByHabitUsecase>(() =>
      _i70.HasCompetitionByHabitUsecase(
          get<_i23.ICompetitionsRepository>(), get<_i26.IUserRepository>()));
  gh.lazySingletonAsync<_i71.HomeController>(() async => _i71.HomeController(
      await get.getAsync<_i64.GetHabitsUsecase>(),
      await get.getAsync<_i49.CompleteHabitUsecase>(),
      await get.getAsync<_i32.MaxHabitsUsecase>(),
      get<_i5.IFireAnalytics>(),
      get<_i3.AppLogic>(),
      get<_i69.GetUserDataUsecase>(),
      get<_i41.UpdateLevelUsecase>(),
      get<_i22.SharedPref>()));
  gh.lazySingletonAsync<_i72.PendingCompetitionController>(() async =>
      _i72.PendingCompetitionController(
          get<_i31.MaxCompetitionsUsecase>(),
          await get.getAsync<_i64.GetHabitsUsecase>(),
          get<_i22.SharedPref>(),
          get<_i65.GetPendingCompetitionsUsecase>(),
          get<_i52.DeclineCompetitionRequestUsecase>()));
  gh.lazySingleton<_i73.PendingFriendsController>(() =>
      _i73.PendingFriendsController(
          get<_i66.GetPendingFriendsUsecase>(),
          get<_i46.AcceptRequestUsecase>(),
          get<_i53.DeclineRequestUsecase>(),
          get<_i22.SharedPref>()));
  gh.lazySingleton<_i74.SettingsController>(() => _i74.SettingsController(
      get<_i22.SharedPref>(),
      get<_i60.GetCompetitionsUsecase>(),
      get<_i42.UpdateNameUsecase>(),
      get<_i29.LogoutUsecase>(),
      get<_i33.RecalculateScoreUsecase>(),
      get<_i28.IsLoggedUsecase>(),
      get<_i69.GetUserDataUsecase>()));
  gh.lazySingletonAsync<_i75.StatisticsController>(() async =>
      _i75.StatisticsController(
          await get.getAsync<_i64.GetHabitsUsecase>(),
          get<_i69.GetUserDataUsecase>(),
          await get.getAsync<_i57.GetAllDaysDoneUsecase>(),
          get<_i18.IScoreService>()));
  gh.lazySingleton<_i76.AddFriendController>(() => _i76.AddFriendController(
      get<_i36.SearchEmailUsecase>(),
      get<_i56.FriendRequestUsecase>(),
      get<_i48.CancelFriendRequestUsecase>(),
      get<_i46.AcceptRequestUsecase>()));
  gh.lazySingletonAsync<_i77.AddHabitController>(() async =>
      _i77.AddHabitController(await get.getAsync<_i47.AddHabitUsecase>()));
  gh.lazySingletonAsync<_i78.CompetitionController>(() async =>
      _i78.CompetitionController(
          await get.getAsync<_i64.GetHabitsUsecase>(),
          get<_i67.GetRankingFriendsUsecase>(),
          get<_i69.GetUserDataUsecase>(),
          get<_i60.GetCompetitionsUsecase>(),
          get<_i59.GetCompetitionUsecase>(),
          get<_i31.MaxCompetitionsUsecase>(),
          get<_i22.SharedPref>(),
          get<_i34.RemoveCompetitorUsecase>(),
          get<_i62.GetFriendsUsecase>()));
  gh.lazySingleton<_i79.CompetitionDetailsController>(() =>
      _i79.CompetitionDetailsController(
          get<_i62.GetFriendsUsecase>(),
          get<_i34.RemoveCompetitorUsecase>(),
          get<_i38.UpdateCompetitionUsecase>()));
  gh.lazySingletonAsync<_i80.CreateCompetitionController>(() async =>
      _i80.CreateCompetitionController(
          await get.getAsync<_i50.CreateCompetitionUsecase>(),
          get<_i30.MaxCompetitionsByHabitUsecase>()));
  gh.lazySingleton<_i81.FriendsController>(() => _i81.FriendsController(
      get<_i62.GetFriendsUsecase>(),
      get<_i69.GetUserDataUsecase>(),
      get<_i35.RemoveFriendUsecase>(),
      get<_i22.SharedPref>()));
  gh.lazySingletonAsync<_i82.HabitDetailsController>(() async =>
      _i82.HabitDetailsController(
          await get.getAsync<_i49.CompleteHabitUsecase>(),
          await get.getAsync<_i63.GetHabitUsecase>(),
          get<_i70.HasCompetitionByHabitUsecase>(),
          await get.getAsync<_i58.GetCalendarDaysDoneUsecase>()));
  gh.lazySingletonAsync<_i83.EditAlarmController>(() async =>
      _i83.EditAlarmController(
          await get.getAsync<_i82.HabitDetailsController>(),
          await get.getAsync<_i43.UpdateReminderUsecase>(),
          get<_i5.IFireAnalytics>()));
  gh.lazySingletonAsync<_i84.EditCueController>(() async =>
      _i84.EditCueController(
          await get.getAsync<_i40.UpdateHabitUsecase>(),
          get<_i5.IFireAnalytics>(),
          await get.getAsync<_i82.HabitDetailsController>()));
  return get;
}
