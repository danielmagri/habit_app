import 'package:altitude/common/view/Header.dart';
import 'package:altitude/common/view/dialog/TutorialDialog.dart';
import 'package:altitude/common/view/generic/DataError.dart';
import 'package:altitude/common/view/generic/Skeleton.dart';
import 'package:altitude/core/base/base_state.dart';
import 'package:altitude/common/constant/ads_utils.dart';
import 'package:altitude/feature/statistics/domain/models/habit_statistic_data.dart';
import 'package:altitude/feature/statistics/presentation/controllers/statistics_controller.dart';
import 'package:altitude/feature/statistics/presentation/widgets/frequency_chart.dart';
import 'package:altitude/feature/statistics/presentation/widgets/historic_chart.dart';
import 'package:altitude/feature/statistics/presentation/widgets/indicator.dart';
import 'package:altitude/feature/statistics/presentation/widgets/pie_chart_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:altitude/core/extensions/NavigatorExtension.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Statisticspage extends StatefulWidget {
  @override
  _StatisticspageState createState() => _StatisticspageState();
}

class _StatisticspageState extends BaseStateWithController<Statisticspage, StatisticsController> {
  final BannerAd banner = BannerAd(
      adUnitId: AdsUtils.statisticsBannerAdUnitId,
      size: AdSize.largeBanner,
      request: AdsUtils.adRequest,
      listener: AdsUtils.adBannerListener);

  @override
  void initState() {
    super.initState();
    banner.load();
    controller.fetchData();
  }

  @override
  void dispose() {
    banner.dispose();
    super.dispose();
  }

  void showPercentageTutorial() {
    Navigator.of(context).smooth(TutorialDialog(
      hero: "helpPercentage",
      texts: const [TextSpan(text: "A porcentagem mostra a representação de cada hábito na sua quilometragem total.")],
    ));
  }

  void showHistoricTutorial() {
    Navigator.of(context).smooth(TutorialDialog(
      hero: "helpHistoric",
      texts: const [TextSpan(text: "O histórico mostra quantos quilômetros você ganhou em cada mês.")],
    ));
  }

  void showFrequencyTutorial() {
    Navigator.of(context).smooth(TutorialDialog(
      hero: "helpFrequency",
      texts: const [
        TextSpan(text: "A frequência mostra quais dias da semana você mais realizou seus hábitos em cada mês.")
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Header(title: "ESTATÍSTICAS"),
            const SizedBox(height: 20),
            Observer(
                builder: (_) => controller.habitsData.handleState(
                    () => Skeleton.custom(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 15,
                            spacing: 15,
                            children: List.generate(
                              5,
                              (index) => Container(
                                width: 90,
                                height: 20,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                    (data) => Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: data!.map<Widget>((data) => Indicator(data: data, onClick: controller.selectHabit)).toList(),
                        ),
                    (error) => DataError())),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 24),
              child: Row(
                children: [
                  const HeaderSection(title: "Porcetagem"),
                  IconButton(
                      iconSize: 22,
                      icon: const Hero(tag: "helpPercentage", child: Icon(Icons.help_outline)),
                      onPressed: showPercentageTutorial)
                ],
              ),
            ),
            Container(
                width: double.maxFinite,
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Observer(
                  builder: (_) => controller.habitsData.handleState(
                      () => Skeleton.custom(
                              child: PieChartScore(data: [
                            HabitStatisticData("", 25, "", 1, 100),
                            HabitStatisticData("", 25, "", 1, 100),
                            HabitStatisticData("", 25, "", 1, 100),
                            HabitStatisticData("", 25, "", 1, 100),
                          ])),
                      (data) => PieChartScore(data: data!.toList(), onClick: controller.selectHabit),
                      (error) => DataError()),
                )),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 24),
              child: Row(
                children: [
                  const HeaderSection(title: "Histórico"),
                  IconButton(
                      iconSize: 22,
                      icon: const Hero(tag: "helpHistoric", child: Icon(Icons.help_outline)),
                      onPressed: showHistoricTutorial)
                ],
              ),
            ),
            Observer(
              builder: (_) => controller.historicData.handleState(
                  () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Skeleton(width: double.maxFinite, height: HISTORIC_CHART_HEIGHT),
                      ),
                  (data) => HistoricChart(list: data!, selectedHabitId: controller.selectedId),
                  (error) => DataError()),
            ),
            const SizedBox(height: 25),
            Container(
              alignment: Alignment.center,
              child: AdWidget(ad: banner),
              width: banner.size.width.toDouble(),
              height: banner.size.height.toDouble(),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 24),
              child: Row(
                children: [
                  const HeaderSection(title: "Frequência"),
                  IconButton(
                      iconSize: 22,
                      icon: const Hero(tag: "helpFrequency", child: Icon(Icons.help_outline)),
                      onPressed: showFrequencyTutorial)
                ],
              ),
            ),
            Observer(
              builder: (_) => controller.frequencyData.handleState(
                  () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Skeleton(width: double.maxFinite, height: FREQUENCY_CHART_HEIGHT),
                      ),
                  (data) => FrequencyChart(list: data, selectedHabitId: controller.selectedId),
                  (error) => DataError()),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  Widget build(BuildContext context) {
    return Text(title!, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20));
  }
}
