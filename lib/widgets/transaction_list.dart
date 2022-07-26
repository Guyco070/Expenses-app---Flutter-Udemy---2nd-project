import 'package:expenses_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constarints) {
                return Column(
                  children: [
                    Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constarints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover),
                    ),
                  ],
                );
              })
            : ListView(
                children: transactions.map((transaction) => TransactionItem(
                      key: ValueKey(transaction.id),
                      transaction: transaction,
                      deleteTransaction: deleteTransaction)
                ).toList(),
              )
        // ListView.builder( // not posible using keys with builder (to save background color)
        //     itemBuilder: (ctx, index) {
        //       return TransactionItem(
        //         transaction: transactions[index],
        //         deleteTransaction: deleteTransaction
        //       );
        //     },
        //     itemCount: transactions.length,
        //   )
        );
  }
}
