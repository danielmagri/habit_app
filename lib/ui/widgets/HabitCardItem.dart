import 'package:flutter/material.dart';
import 'package:habit/objects/Habit.dart';
import 'package:habit/utils/Util.dart';
import 'package:habit/utils/Color.dart';

class HabitCardItem extends StatelessWidget {
  HabitCardItem({Key key, this.habit}) : super(key: key);

  final Habit habit;

  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () => Util.goDetailsPage(context, habit.id),
      child: SizedBox(
        height: 90.0,
        width: 110.0,
        child: Column(
          children: <Widget>[
            Container(
              width: 70.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: HabitColors.colors[habit.color],
                boxShadow: <BoxShadow>[BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.5))],
              ),
              child: Icon(
                IconData(habit.icon, fontFamily: 'MaterialIcons'),
                size: 32.0,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                habit.habit,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
