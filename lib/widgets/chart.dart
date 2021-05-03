import 'package:expense_trcker/model/transaction.dart';
import 'package:expense_trcker/widgets/chat_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesChart extends StatelessWidget {
  // all the transactions that happened in the last 7 days.
  final List<Transaction> recentTransaction;
  ExpensesChart(this.recentTransaction);
  // a getter to dynamically generate a list of the amount
  // of money that were spent in every day of the 7.
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].time.day == weekDay.day &&
            recentTransaction[i].time.month == weekDay.month &&
            recentTransaction[i].time.year == weekDay.year) {
          totalSum += recentTransaction[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

// a getter to dynamically calculate the totalSpending of the week
  get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      // previousValue is the last calculated value
      return previousValue += element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ExpensesChartBar(
                  label: data['day'],
                  spentAmount: data['amount'],
                  spendingPercentageOfTotal: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
