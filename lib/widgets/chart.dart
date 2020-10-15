import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../models/transactions.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.vertical(
            bottom: Radius.circular(25), top: Radius.zero)),
        depth: 0,
        lightSource: LightSource.top,
        color: Colors.white,
        // border: NeumorphicBorder(
        //     // isEnabled: true,
        //     // color: Colors.black,
        //     ),
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return totalSpending == 0
                  ? ChartBar(
                      data['day'],
                      0,
                      0,
                    )
                  : Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        data['day'],
                        data['amount'],
                        (data['amount'] as double) / totalSpending,
                      ),
                    );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
