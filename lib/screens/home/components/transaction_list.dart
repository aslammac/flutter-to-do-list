import 'package:flutter/material.dart';
import '../../../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function removeEachTransaction;
  final List<Transactions> transactions;
  TransactionList(this.transactions, this.removeEachTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.6,

      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Transactions!!',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/images.png',
                        fit: BoxFit.scaleDown,
                        scale: 2,
                        alignment: Alignment.topCenter,
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(5),
                  color: Theme.of(context).cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '₹' + transactions[index].amount.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      MediaQuery.of(context).size.width > 450
                          ? FlatButton.icon(
                              textColor: Theme.of(context).errorColor,
                              onPressed: () =>
                                  removeEachTransaction(transactions[index].id),
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              label: Text(
                                'Delete',
                              ))
                          : IconButton(
                              iconSize: 25,
                              color: Theme.of(context).errorColor,
                              icon: Icon(Icons.delete),
                              onPressed: () => removeEachTransaction(
                                  transactions[index].id)),
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
