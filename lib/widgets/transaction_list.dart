import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

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
                    SizedBox(
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
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 5,
                    ),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('\$${transactions[index].amount}'),
                            ),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy')
                              .format(transactions[index].date),
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: MediaQuery.of(context).size.width > 460 ? FlatButton.icon(
                                onPressed: () =>
                                deleteTransaction(transactions[index].id), 
                                icon: Icon(Icons.delete), 
                                label: Text("Delete"),
                                textColor: Theme.of(context).errorColor,
                              ) : 
                              IconButton(
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor)),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
