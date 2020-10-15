import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/new_transaction.dart';
import '../../models/transactions.dart';
import '../home/components/transaction_list.dart';
import '../../widgets/chart.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showChart = false;
  List<Transactions> get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: selectedDate);

    setState(() {
      transactions.add(newTx);
    });
  }

  void removeTransaction(String title, double amount) {
    setState(() {
      transactions.removeWhere((element) => element.title == title);
    });
  }

  void removeEachTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Widget> _buildLandscapeContent(
      double usableHeight, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          Switch(
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: usableHeight * 0.7,
              child: Chart(
                recentTransactions,
              ))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(double usableHeight, Widget txListWidget) {
    return [
      Container(
          height: usableHeight * 0.3,
          child: Chart(
            recentTransactions,
          )),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Tracker'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => startNewTransaction(context),
              ),
            ],
            title: Text(
              'Expense Tracker',
            ),
            brightness: Brightness.light,
            elevation: 0,
            textTheme: Theme.of(context).textTheme,
          );
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final double usableHeight = MediaQuery.of(context).size.height -
        (appBar.preferredSize.height + MediaQuery.of(context).padding.top);
    final txListWidget = Container(
      height: usableHeight * 0.7,
      child: TransactionList(transactions, removeEachTransaction),
    );

    final appBody = SafeArea(
      child: Column(
        children: [
          if (isLandscape)
            ..._buildLandscapeContent(usableHeight, txListWidget),
          if (!isLandscape)
            ..._buildPortraitContent(usableHeight, txListWidget),
        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: appBody,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
