import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (Transaction trx in recentTransaction) {
        if (DateFormat.yMMMd().format(trx.date) ==
            DateFormat.yMMMd().format(weekDay)) totalSum += trx.amount;
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactionValues.map((data) {
              return ChartBar(
                label: '${data['day']}',
                spendingAmount: data['amount'],
                spendintPctOfTotal: totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
              );
            }).toList(),
          ),
        ),
        elevation: 6,
        margin: EdgeInsets.all(20),
      );
  }
}
