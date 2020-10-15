import 'package:flutter/foundation.dart';

class Transactions {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transactions(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}

final List<Transactions> transactions = [
  Transactions(
    id: '10a',
    title: 'Adidas',
    amount: 25,
    date: DateTime.now(),
  ),
  Transactions(
    id: '10aff',
    title: 'Nike',
    amount: 500,
    date: DateTime.now(),
  ),
  Transactions(
    id: '10af',
    title: 'Koler',
    amount: 500,
    date: DateTime.now().subtract(Duration(days: 1)),
  ),
  Transactions(
    id: '10av',
    title: 'Nivia',
    amount: 500,
    date: DateTime.now().subtract(Duration(days: 3)),
  ),
  Transactions(
    id: '10ab',
    title: 'Puma',
    amount: 600,
    date: DateTime.now().subtract(Duration(days: 2)),
  ),
  Transactions(
    id: '10ab',
    title: 'Reebok',
    amount: 620,
    date: DateTime.now().subtract(Duration(days: 2)),
  ),
  Transactions(
    id: '10ab',
    title: 'Puma',
    amount: 600,
    date: DateTime.now().subtract(Duration(days: 2)),
  )
];
