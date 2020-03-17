import 'package:altitude/common/view/generic/Loading.dart';
import 'package:altitude/common/view/generic/Toast.dart';
import 'package:flutter/material.dart';
import 'package:altitude/controllers/CompetitionsControl.dart';
import 'package:altitude/controllers/HabitsControl.dart';
import 'package:altitude/utils/Validator.dart';
import 'package:altitude/ui/addHabit/widgets/colorWidget.dart';
import 'package:altitude/ui/addHabit/widgets/habitWidget.dart';
import 'package:altitude/ui/addHabit/widgets/frequencyWidget.dart';
import 'package:altitude/utils/Color.dart';
import 'package:altitude/datas/dataHabitCreation.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:altitude/ui/dialogs/BaseDialog.dart';

class EditHabitPage extends StatefulWidget {
  EditHabitPage({Key key}) : super(key: key);

  @override
  _EditHabitPagePageState createState() => _EditHabitPagePageState();
}

class _EditHabitPagePageState extends State<EditHabitPage> {
  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();

  final habitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // DataHabitCreation().indexColor = DataHabitDetail().habit.color;
    // DataHabitCreation().frequency = DataHabitDetail().frequency;

    // habitController.text = DataHabitDetail().habit.habit;
  }

  @override
  void dispose() {
    habitController.dispose();
    _keyboardVisibility.dispose();
    super.dispose();
  }

  void changeColor(int index) {
    setState(() {
      DataHabitCreation().indexColor = index;
    });
  }

  void _removeHabit() {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return BaseDialog(
    //       title: "Deletar",
    //       body: "Você estava indo tão bem... Tem certeza que quer deletá-lo?",
    //       subBody: "(Todo o progresso dele será perdido e a quilômetragem perdida)",
    //       action: <Widget>[
    //         new FlatButton(
    //           child: new Text(
    //             "SIM",
    //             style: TextStyle(fontSize: 17),
    //           ),
    //           onPressed: () {
    //             HabitsControl()
    //                 .deleteHabit(DataHabitDetail().habit.id, DataHabitDetail().habit.habit,
    //                     DataHabitDetail().habit.score, DataHabitDetail().reminders)
    //                 .then((status) {
    //               Navigator.of(context).popUntil((route) => route.isFirst);
    //             });
    //           },
    //         ),
    //         new FlatButton(
    //           child: new Text(
    //             "NÃO",
    //             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //           ),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _createHabitTap() async {
    // if (Validate.habitTextValidate(habitController.text) != null) {
    //   showToast("O hábito precisa ser preenchido.");
    // } else if (DataHabitCreation().frequency == null) {
    //   showToast("Escolha qual será a frequência.");
    // } else {
    //   Habit editedHabit = new Habit(
    //       id: DataHabitDetail().habit.id,
    //       color: DataHabitCreation().indexColor,
    //       habit: habitController.text,
    //       cue: DataHabitDetail().habit.cue,
    //       score: DataHabitDetail().habit.score,
    //       daysDone: DataHabitDetail().habit.daysDone,
    //       initialDate: DataHabitDetail().habit.initialDate);

    //   Loading.showLoading(context);

    //   if (editedHabit.color != DataHabitDetail().habit.color ||
    //       editedHabit.habit.compareTo(DataHabitDetail().habit.habit) != 0) {
    //     await HabitsControl()
    //         .updateHabit(editedHabit, DataHabitDetail().habit, DataHabitDetail().reminders);
    //   }

    //   if (!compareFrequency(DataHabitDetail().frequency, DataHabitCreation().frequency)) {
    //     await HabitsControl().updateFrequency(
    //         editedHabit.id, DataHabitCreation().frequency, DataHabitDetail().frequency.runtimeType);
    //   }

    //   Loading.closeLoading(context);

    //   DataHabitDetail().habit = editedHabit;
    //   DataHabitDetail().frequency = DataHabitCreation().frequency;
    //   Navigator.of(context).pop();
    //   showToast("O hábito foi editado!");
    // }
  }

  bool compareFrequency(dynamic f1, dynamic f2) {
    // if (f1.runtimeType == f2.runtimeType) {
    //   switch (f1.runtimeType) {
    //     case DayWeek:
    //       DayWeek dayweek1 = f1;
    //       DayWeek dayweek2 = f2;
    //       if (dayweek1.sunday == dayweek2.sunday &&
    //           dayweek1.monday == dayweek2.monday &&
    //           dayweek1.tuesday == dayweek2.tuesday &&
    //           dayweek1.wednesday == dayweek2.wednesday &&
    //           dayweek1.thursday == dayweek2.thursday &&
    //           dayweek1.friday == dayweek2.friday &&
    //           dayweek1.saturday == dayweek2.saturday) {
    //         return true;
    //       }
    //       return false;
    //     case Weekly:
    //       Weekly weekly1 = f1;
    //       Weekly weekly2 = f2;
    //       if (weekly1.daysTime == weekly2.daysTime) {
    //         return true;
    //       }
    //       return false;
    //   }
    // }
    // return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: BackButton(),
                  ),
                  Spacer(),
                  Text(
                    "EDITAR HÁBITO",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 50,
                    child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          // Loading.showLoading(context);
                          // var listCompetitions = await CompetitionsControl()
                          //     .listCompetitionsIds(DataHabitDetail().habit.id);
                          // Loading.closeLoading(context);
                          // if (listCompetitions.isEmpty) {
                          //   _removeHabit();
                          // } else {
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return BaseDialog(
                          //         title: "Opss",
                          //         body:
                          //             "É preciso sair das competições que esse hábito faz parte para poder deletá-lo.",
                          //         action: <Widget>[
                          //           new FlatButton(
                          //             child: new Text(
                          //               "Ok",
                          //               style: TextStyle(fontSize: 17),
                          //             ),
                          //             onPressed: () {
                          //               Navigator.pop(context);
                          //             },
                          //           ),
                          //         ],
                          //       );
                          //     },
                          //   );
                          // }
                        }),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 30),
            ),
            ColorWidget(
              currentColor: DataHabitCreation().indexColor,
              changeColor: changeColor,
            ),
            SizedBox(
              height: 20,
            ),
            HabitWidget(
              color: AppColors.habitsColor[DataHabitCreation().indexColor],
              controller: habitController,
              keyboard: _keyboardVisibility,
            ),
            FrequencyWidget(
              color: AppColors.habitsColor[DataHabitCreation().indexColor],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 28),
              child: RaisedButton(
                color: AppColors.habitsColor[DataHabitCreation().indexColor],
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 16.0),
                elevation: 5.0,
                onPressed: _createHabitTap,
                child: const Text(
                  "SALVAR",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
