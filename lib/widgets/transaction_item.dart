import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 5,
      ),
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text('\$${transaction.amount}'),
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            DateFormat('dd/MM/yyyy').format(transaction.date),
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  onPressed: () => deleteTransaction(transaction.id),
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  textColor: Theme.of(context).errorColor,
                )
              : IconButton(
                  onPressed: () => deleteTransaction(transaction.id),
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor)),
    );
  }
}
