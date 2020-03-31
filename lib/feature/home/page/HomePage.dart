import 'package:altitude/common/view/Score.dart';
import 'package:altitude/common/view/generic/Skeleton.dart';
import 'package:altitude/core/view/BasePage.dart';
import 'package:altitude/feature/home/dialogs/NewLevelDialog.dart';
import 'package:altitude/feature/home/viewmodel/HomeViewModel.dart';
import 'package:altitude/feature/home/widget/AllHabits.dart';
import 'package:altitude/feature/home/widget/HomeBottomNavigation.dart';
import 'package:altitude/feature/home/widget/HomeDrawer.dart';
import 'package:altitude/feature/home/widget/SkyDragTarget.dart';
import 'package:altitude/feature/home/widget/TodayHabits.dart';
import 'package:altitude/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:altitude/controllers/LevelControl.dart';
import 'package:provider/provider.dart';

class HomePage extends BasePage<HomeViewModel> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController(initialPage: 1);

  @override
  HomeViewModel createViewModel() => HomeViewModel();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // @override
  // initState() {
  //   super.initState();

  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //       statusBarColor: Color.fromARGB(100, 250, 250, 250),
  //       systemNavigationBarColor: Color.fromARGB(255, 250, 250, 250),
  //       systemNavigationBarIconBrightness: Brightness.dark));

  //   WidgetsBinding.instance.addObserver(this);
  // }

  void showDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  // @override
  // didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //         statusBarColor: Color.fromARGB(100, 250, 250, 250),
  //         systemNavigationBarColor: Color.fromARGB(255, 250, 250, 250),
  //         systemNavigationBarIconBrightness: Brightness.dark));
  //   }
  //   super.didChangeAppLifecycleState(state);
  // }

  void setHabitDone(BuildContext context, id) {
    showLoading(context, true);

    getViewModel(context).completeHabit(id).then((newScore) async {
      showLoading(context, false);
      vibratePhone();

      if (await getViewModel(context).checkLevelUp(newScore)) {
        navigateSmooth(context, NewLevelDialog(score: newScore));
      }
    }).catchError((error) {
      showLoading(context, false);
      showToast("Ocorreu um erro");
    });
  }

  void pageScroll(int index) {
    pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  void goAllLevels(BuildContext context) {
    Navigator.pushNamed(context, 'allLevels', arguments: getViewModel(context).user.data.score);
  }

  @override
  Widget builder(context, viewmodel) {
    return Scaffold(
        key: scaffoldKey,
        drawer: const HomeDrawer(),
        drawerScrimColor: Colors.black12,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 75,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        tooltip: "Menu",
                        icon: Icon(Icons.menu),
                        onPressed: showDrawer,
                      ),
                      Spacer(),
                      // FutureBuilder<bool>(
                      //     future: Util.checkUpdatedVersion(),
                      //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      //       return !snapshot.data
                      //           ? IconButton(
                      //               tooltip: "News",
                      //               icon: new Hero(
                      //                 tag: "newsRelease",
                      //                 child: Icon(
                      //                   Icons.new_releases,
                      //                 ),
                      //               ),
                      //               onPressed: () {
                      //                 Util.dialogNavigator(
                      //                     context,
                      //                     TutorialDialog(
                      //                       hero: "newsRelease",
                      //                       icon: Icons.new_releases,
                      //                       texts: [
                      //                         TextSpan(
                      //                           text: "  A pontuação do hábito mudou!",
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 18.0,
                      //                               fontWeight: FontWeight.bold,
                      //                               height: 1.2),
                      //                         ),
                      //                         TextSpan(
                      //                           text:
                      //                               " Agora a cada dia completado você ganha 2km.\n\n E ao completar a frequência na semana (por exemplo: 3 vezes na semana ou segunda, quarta e sexta) os dias passam a valer 3km, tanto os dias dessa semana que ja foi marcado quanto os que marcar!",
                      //                           style: TextStyle(color: Colors.black, fontSize: 18.0, height: 1.2),
                      //                         ),
                      //                       ],
                      //                     )).then((data) async {
                      //                   int version = int.parse((await PackageInfo.fromPlatform()).buildNumber);
                      //                   SharedPref().setVersion(version);
                      //                 });
                      //               },
                      //             )
                      //           : Container();
                      //     }),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => goAllLevels(context),
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 25),
                        viewmodel.user.handleState(
                          () {
                            return Skeleton.custom(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 20,
                                    decoration:
                                        BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(15)),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 120,
                                    height: 80,
                                    decoration:
                                        BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(15)),
                                  )
                                ],
                              ),
                            );
                          },
                          (data) {
                            return Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 3,
                                ),
                                Text(LevelControl.getLevelText(data.score)),
                                Score(color: AppColors.colorAccent, score: data.score),
                              ],
                            );
                          },
                          (error) {
                            return SizedBox();
                          },
                        ),
                        viewmodel.user.handleState(
                          () {
                            return Skeleton(
                              width: 25,
                              height: 25,
                              margin: const EdgeInsets.only(bottom: 4, right: 8),
                            );
                          },
                          (data) {
                            return Image.asset(
                              LevelControl.getLevelImagePath(data.score),
                              height: 25,
                              width: 25,
                            );
                          },
                          (error) {
                            return SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    onPageChanged: Provider.of<HomeViewModel>(context, listen: false).swipedPage,
                    children: <Widget>[
                      const AllHabitsPage(),
                      const TodayHabits(),
                    ],
                  ),
                ),
              ],
            ),
            SkyDragTarget(
                visibilty: Provider.of<HomeViewModel>(context, listen: false).visibilty, setHabitDone: setHabitDone),
          ],
        ),
        bottomNavigationBar: HomebottomNavigation(pageScroll: pageScroll));
  }
}
