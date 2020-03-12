import 'package:altitude/core/bloc/BlocProvider.dart';
import 'package:altitude/core/bloc/BlocWidget.dart';
import 'package:altitude/core/bloc/model/LoadableData.dart';
import 'package:altitude/enums/DonePageType.dart';
import 'package:altitude/model/Frequency.dart';
import 'package:altitude/ui/habitDetails/dialogs/EditAlarmDialog.dart';
import 'package:altitude/ui/habitDetails/dialogs/EditCueDialog.dart';
import 'package:altitude/ui/editHabitPage.dart';
import 'package:altitude/ui/habitDetails/blocs/habitDetailsBloc.dart';
import 'package:altitude/ui/habitDetails/enums/BottomSheetType.dart';
import 'package:altitude/ui/habitDetails/widgets/calendarWidget.dart';
import 'package:altitude/ui/habitDetails/widgets/competitionWidget.dart';
import 'package:altitude/ui/habitDetails/widgets/coolDataWidget.dart';
import 'package:altitude/ui/habitDetails/widgets/cueWidget.dart';
import 'package:altitude/ui/habitDetails/widgets/headerWidget.dart';
import 'package:altitude/ui/widgets/generic/Skeleton.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:altitude/core/extensions/DateTimeExtension.dart';

class HabitDetailsPage extends BlocWidget<HabitDetailsBloc> {
  static StatefulWidget instance(int habitId, int color) {
    return BlocProvider<HabitDetailsBloc>(
      blocCreator: () => HabitDetailsBloc(habitId, color),
      widget: HabitDetailsPage(),
    );
  }

  Future<bool> onBackPress(HabitDetailsBloc bloc) {
    if (bloc.panelController.isPanelOpen()) {
      bloc.closeBottomSheet();
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _bottomSheetBuilder(BottomSheetType type, HabitDetailsBloc bloc) {
    switch (type) {
      case BottomSheetType.CUE:
        return EditCueDialog.instance(bloc.habit, bloc.editCueCallback);
      case BottomSheetType.REMINDER:
        return EditAlarmDialog.instance(bloc.habit, bloc.reminders, bloc.editAlarmCallback);
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context, HabitDetailsBloc bloc) {
    return WillPopScope(
      onWillPop: () => onBackPress(bloc),
      child: Scaffold(
        body: SlidingUpPanel(
          controller: bloc.panelController,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          backdropEnabled: true,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minHeight: 0,
          onPanelClosed: bloc.emptyBottomSheet,
          panel: StreamBuilder<BottomSheetType>(
            stream: bloc.bottomSheetStream,
            builder: (BuildContext context, AsyncSnapshot<BottomSheetType> snapshot) =>
                _bottomSheetBuilder(snapshot.data, bloc),
          ),
          body: SingleChildScrollView(
            controller: bloc.scrollController,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 75,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BackButton(color: bloc.habitColor),
                      Spacer(),
                      StreamBuilder<int>(
                          stream: bloc.reminderButtonStream,
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            if (snapshot.hasData) {
                              return IconButton(
                                icon: Icon(
                                  snapshot.data != 0 ? Icons.alarm_on : Icons.add_alarm,
                                  size: 25,
                                  color: bloc.habitColor,
                                ),
                                onPressed: () => bloc.openBottomSheet(BottomSheetType.REMINDER),
                              );
                            } else if (snapshot.hasError) {
                              return SizedBox();
                            } else {
                              return Skeleton(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(bottom: 4),
                              );
                            }
                          }),
                      IconButton(
                        icon: Icon(Icons.edit, size: 25, color: bloc.habitColor),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) {
                                    return EditHabitPage();
                                  },
                                  settings: RouteSettings(name: "Edit Habit Page")));
                        },
                      ),
                    ],
                  ),
                ),
                HeaderWidget(bloc: bloc),
                Container(
                  margin: const EdgeInsets.only(top: 36, bottom: 4, left: 32, right: 32),
                  width: double.maxFinite,
                  height: 50,
                  child: StreamBuilder<LoadableData<bool>>(
                    stream: bloc.completeButtonStram,
                    builder: (BuildContext context, AsyncSnapshot<LoadableData<bool>> snapshot) {
                      if (snapshot.hasData) {
                        return RaisedButton(
                          color: snapshot.data.data ? bloc.habitColor : Colors.white,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          elevation: 5.0,
                          onPressed: () {
                            if (!snapshot.data.data)
                              bloc.completeHabit(true, DateTime.now().today, DonePageType.Detail);
                          },
                          child: snapshot.data.loading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: new AlwaysStoppedAnimation<Color>(
                                          snapshot.data.data ? Colors.white : bloc.habitColor)),
                                )
                              : Text(
                                  snapshot.data.data ? "HÁBITO COMPLETO!" : "COMPLETAR HÁBITO HOJE",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: snapshot.data.data ? Colors.white : bloc.habitColor,
                                      fontWeight: FontWeight.bold),
                                ),
                        );
                      } else if (snapshot.hasError) {
                        return SizedBox();
                      } else {
                        return Skeleton(
                          width: double.maxFinite,
                          height: 50,
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: StreamBuilder<Frequency>(
                    stream: bloc.frequencyTextStream,
                    builder: (BuildContext context, AsyncSnapshot<Frequency> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.frequencyText(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black54),
                        );
                      } else if (snapshot.hasError) {
                        return SizedBox();
                      } else {
                        return Skeleton(
                          width: 200,
                          height: 20,
                        );
                      }
                    },
                  ),
                ),
                CueWidget(bloc: bloc),
                SizedBox(height: 16),
                CalendarWidget(bloc: bloc),
                SizedBox(height: 16),
                StreamBuilder<List<String>>(
                    stream: bloc.competitionListStream,
                    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data.isEmpty ? CompetitionWidget(bloc: bloc) : SizedBox();
                      } else if (snapshot.hasError) {
                        return SizedBox();
                      } else {
                        return Skeleton(
                          width: double.maxFinite,
                          height: 130,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                        );
                      }
                    }),
                SizedBox(height: 16),
                CoolDataWidget(bloc: bloc),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
