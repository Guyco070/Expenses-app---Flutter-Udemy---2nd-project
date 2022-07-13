import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                  ),
                ],
              )
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
                                  DateFormat('dd/MM/yyyy').format(transactions[index].date),
                                  style: TextStyle(color: Colors.grey),
                                ),
                    ),
                  );
                  // Card(
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //               margin: EdgeInsets.symmetric(
                  //                 vertical: 10,
                  //                 horizontal: 15,
                  //               ),
                  //               decoration: BoxDecoration(
                  //                   border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
                  //               padding: EdgeInsets.all(10),
                  //               child: Text('\$${transactions[index].amount}',
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 20,
                  //                       color: Theme.of(context).primaryColor)),
                  //             ),
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   transactions[index].title,
                  //                   style: Theme.of(context).textTheme.titleMedium,
                  //                 ),
                  //                 Text(
                  //                   DateFormat('dd/MM/yyyy').format(transactions[index].date),
                  //                   style: TextStyle(color: Colors.grey),
                  //                 ),
                  //               ],
                  //             )
                  //           ],
                  //         ),
                  //         elevation: 2,
                  //       );
                },
                itemCount: transactions.length,
              ));
  }
}
