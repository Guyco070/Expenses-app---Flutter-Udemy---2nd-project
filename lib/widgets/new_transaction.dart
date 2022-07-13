import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addHandler;

  NewTransaction(this._addHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isNotEmpty && enteredAmount != null && enteredAmount > 0) {
      widget._addHandler(enteredTitle, enteredAmount);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => submitData(),
          ),
          TextField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            controller: _amountController,
            onSubmitted: (_) => submitData(),
          ),
          Row(
            children: [
              Text('No Date Chosen!'),
              FlatButton(onPressed: () {}, child: Text('Choose Date'), textColor: Theme.of(context).primaryColor, )
            ],
          ),
          FlatButton(
            onPressed: submitData,
            child: Text(
              'Add Transaction',
            ),
            textColor: Colors.purple,
          )
        ]),
      ),
    );
  }
}
